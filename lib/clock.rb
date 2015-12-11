# encoding: utf-8
require 'json'
###
# @author Dan Oberg <dan@cs1.com>
# @class Clock
###
class Clock
  ###
  # @method add_minute
  ###
  def self.add_minute
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
      @hours_passed += 12
      @cycle_days = @hours_passed / 24
      if @current_que == @start_order
        @repeat = true
      end
    end 
  end

  ###
  # @param [Fixnum, Fixnum] runs clock with number of balls and optionally a runtime.
  # @return [Json] json hash for min, five_min, hour and main queues. If no runtime
  #   is provided will calculate days tell que repeats.
  ###
  def self.run_ball_clock(balls, run_time)
    @min = []
    @five_min = []
    @hour = []
    @main = []
    @result = []
    @current_que = []
    @hours_passed = '0'.to_i
    @repeat = false
    min_left = run_time.to_i
    @start_order = Array.new(balls.to_i) { |i| i + 1 }
    @start_order.freeze
    @min_track = []
    @five_min_track = []
    @hour_track = []
    que_balls = @start_order.clone
    que_balls.each do |ball|
      @current_que << ball
    end
    if run_time.to_i == 0 || nil
      until @repeat == true
        add_minute
      end
      result = puts "Clock cycles in: #{@cycle_days} day\(s\)\."
    else
      until min_left == 0
        add_minute
        min_left -= 1
      end
      json_clock = { min: @min_track, fiveMin: @five_min_track, hour: @hour_track, main: @current_que}
      result = JSON.generate(json_clock)
    end
    result
  end
end
