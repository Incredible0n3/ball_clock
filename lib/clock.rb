# encoding: utf-8
require 'json'
###
# @author Dan Oberg <dan@cs1.com>
# @class Clock
###
class Clock
  # @constant [String] global constant filepath
  @@filepath = nil

  ###
  # @param [String] filepath with tab seperated params as a .txt based database.
  ###
  def self.filepath=(path = nil)
    @@filepath = File.join(APP_ROOT, path)
  end

  ###
  # @attr [String] name
  # @attr [Fixnum] balls
  # @attr [Fixnum] run_time
  # @attr [Array] min
  # @attr [Array] five_min
  # @attr [Array] hour
  # @attr [Hash] result
  # @attr [Fixnum] cycle_days
  ###
  attr_accessor :name, :balls, :run_time, :min, :five_min, :hour, :result, :cycle_days

  def self.file_exists?
    if @@filepath && File.exist?(@@filepath)
      return true
    else
      return false
    end
  end

  ###
  # @method self.file_usable?
  ###
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exist?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    true
  end

  ###
  # @method self.create_file
  ###
  def self.create_file
    # create the clock file
    File.open(@@filepath, 'w') unless file_exists?
    file_usable?
  end

  ###
  # @method self.saved_clocks
  ###
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

  ###
  # @method self.build_using_questions
  ###
  def self.build_using_questions
    args = {}
    print 'Clock name: '
    args[:name] = gets.chomp.strip
    valid = false
    until valid == true
      print "Number of balls to start with\(Min:27 Max:127\): "
      var = gets.chomp.strip.to_i
      if var > 127 || var < 27
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

  ###
  # @param [Hash]
  ###
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

  ###
  # @param [String] splits imported line by tabs and then assigns to attributes.
  ###
  def import_line(line)
    line_array = line.split("\t")
    @name = line_array[0]
    @balls = line_array[1]
    @run_time = line_array[2]
    @result = line_array[3]
    parsed_response = JSON.load(@result)
    @main = parsed_response['main']
    @min = parsed_response['min']
    @five_min = parsed_response['fiveMin']
    @hour = parsed_response['hour']
    @cycle_days = parsed_response['cycleDays']
    return self
  end

  ###
  # @method save
  ###
  def save
    return false unless Clock.file_usable? && !@name.empty?
    response = run_ball_clock(@balls, @run_time)
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@name, @balls, @run_time, response].join("\t")}" + "\n"
    end
    true
  end

  ###
  # @method add_minute
  ###
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

  ###
  # @param [Fixnum, Fixnum] runs clock with number of balls and optionally a runtime.
  # @return [Json] json hash for min, five_min, hour and main queues. If no runtime
  #   is provided will calculate days tell que repeats.
  ###
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
