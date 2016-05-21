require 'minitest/autorun'
require 'clock'

class ClockTest < Minitest::Test
  def test_run_time
    assert_equal "{\"min\":[],\"fiveMin\":[22,13,25,3,7],\"hour\":[6,12,17,4,15],\"main\":[11,5,26,18,2,30,19,8,24,10,29,20,16,21,28,1,23,14,27,9]}",
      Clock.run_ball_clock(30,325)
  end
  def test_cycle_days
    assert_equal "Clock cycles in: 2415 day(s).",
      Clock.run_ball_clock(127,0)
  end
end
