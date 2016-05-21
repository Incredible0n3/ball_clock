# encoding: utf-8
require 'json'
###
# @author Dan Oberg <dan@cs1.com>
# @licence MIT
# @class Clock
# Useage: `ruby -Ilib ./bin/clock {27,0}` or `ruby -Ilib ./bin/clock {30,325}`
###
class Clock
  ###
  # @method add_minute
  # adds a ball from the begining of the main
  # queue to the minute track. Once the minute track is full
  # the ball will drop to the five minute track triggering in
  # reverse order the minute track to deposit to the main queue.
  # When the five minute track is full it will pass the next ball from
  # from the main queue to the hour track which triggers the five min
  # track to drop its balls in reverse order to the main queue. When
  # hour track is full will drop balls in reverse order to the main queue.
  ###
  def self.add_minute
    if @min_track.length < 4
      @min_track << @current_que.shift
    elsif @five_min_track.length < 11
      @five_min_track << @current_que.shift
      @current_que.concat(@min_track.reverse)
      @min_track = []
    elsif @hour_track.length < 11
      @hour_track << @current_que.shift
      @current_que.concat(@min_track.reverse)
      @min_track = []
      @current_que.concat(@five_min_track.reverse)
      @five_min_track = []
    else
      que_ball = @current_que.shift
      @current_que.concat(@min_track.reverse)
      @min_track = []
      @current_que.concat(@five_min_track.reverse)
      @five_min_track = []
      @current_que.concat(@hour_track.reverse)
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
  # @param [Fixnum, Fixnum] runs clock with number of balls to start with and optionally a runtime.
  # @return [Json] json hash for min, five_min, hour and main queues. If no runtime
  # is provided it will calculate the days tell the que repeats.
  ###
  def self.run_ball_clock(balls, run_time)
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
      "Clock cycles in: #{@cycle_days} day\(s\)\."
    else
      until min_left == 0
        add_minute
        min_left -= 1
      end
      JSON.generate(min: @min_track, fiveMin: @five_min_track, hour: @hour_track, main: @current_que)
    end
  end
end
