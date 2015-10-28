require 'json'
class Clock
  @@filepath = nil
  def self.filepath=(path = nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  attr_accessor :name, :balls, :run_time, :min, :five_min, :hour, :result, :cycle_days
  def self.file_exists?
    if @@filepath && File.exist?(@@filepath)
      return true
    else
      return false
    end
  end

  def self.file_usable?
    return false unless @@filepath
    return false unless File.exist?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    true
  end

  def self.create_file
    # create the clock file
    File.open(@@filepath, 'w') unless file_exists?
    file_usable?
  end

  def self.saved_clocks
    clocks = []
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        clocks << Clock.new.import_line(line.chomp)
      end
      file.close
    end
    clocks
  end

  def self.build_using_questions
    args = {}
    print 'Clock name: '
    args[:name] = gets.chomp.strip
    valid = false
    until valid == true
      print "Number of balls to start with\(Min:27 Max:127\): "
      var = gets.chomp.strip.to_i
      if var && var > 127 || var < 27
        print "#{var} is a invalid number!\n"
      else
        valid = true
      end
      
    end
    args[:balls] = var
    print 'Run time in minutes: '
    run_time = gets.chomp.strip.to_i
    args[:run_time] = run_time

    return self.new(args)
  end

  def initialize(args = {})
    @balls = args[:balls] || '0'.to_i
    @name = args[:name] || ''
    @run_time = args[:run_time] || '0'.to_i
    @min = []
    @five_min = []
    @hour = []
    @main = []
    @cycle_days = []
    @result = []
    @current_que = []
    @hours_passed = '0'.to_i
  end

  def import_line(line)
    line_array = line.split("\t")
    @name, @balls, @run_time, @result = line_array
    parsed_response = JSON.load(@result)
    @main = parsed_response['main']
    @min = parsed_response['min']
    @five_min = parsed_response['fiveMin']
    @hour = parsed_response['hour']
    @cycle_days = parsed_response['cycleDays']
    return self
  end

  def save
    return false unless Clock.file_usable? && !@name.empty?

    response = run_ball_clock(@balls, @run_time)
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@name, @balls, @run_time, response].join("\t")}" + "\n"
    end
    true
  end

  def add_minute
    if @min_track.length < 4
      @min_track << @current_que.shift
    elsif @five_min_track.length < 11
      @five_min_track << @current_que.shift
      reverse_track = @min_track.reverse
      @current_que.concat(reverse_track)
      @min_track = []
    elsif @hour_track.length < 11
      @hour_track << @current_que.shift
      reverse_track = @min_track.reverse
      @current_que.concat(reverse_track)
      @min_track = []
      reverse_five_min_track = @five_min_track.reverse
      @current_que.concat(reverse_five_min_track)
      @five_min_track = []
      @hours_passed += 1
    else
      que_ball = @current_que.shift
      reverse_track = @min_track.reverse
      @current_que.concat(reverse_track)
      @min_track = []
      reverse_five_min_track = @five_min_track.reverse
      @current_que.concat(reverse_five_min_track)
      @five_min_track = []
      reverse_hour_track = @hour_track.reverse
      @current_que.concat(reverse_hour_track)
      @current_que << que_ball
      @hour_track = []
      @hours_passed += 1
    end
    @cycle_days = @hours_passed / 24
  end

  def run_ball_clock(balls, run_time)
    min_left = run_time
    @start_order = Array.new(balls) { |i| i + 1 }
    @start_order.freeze
    @min_track = []
    @five_min_track = []
    @hour_track = []
    @hours_passed = '0'.to_i
    @current_que = []
    que_balls = @start_order.clone
    que_balls.each do |ball|
      @current_que << ball
    end
    if run_time == 0
      repeat = false
      until repeat == true
        add_minute
        if @current_que == @start_order
          repeat = true
        else
          repeat = false
        end
      end
    else
      until min_left == 0
        add_minute
        min_left -= 1
      end
    end
    json_clock = { min: @min_track, fiveMin: @five_min_track, hour: @hour_track, main: @current_que, cycleDays: @cycle_days }
    JSON.generate(json_clock)
  end
end
