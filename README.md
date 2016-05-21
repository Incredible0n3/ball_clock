                ____       ___        ____      ____      __      __          ______
               |  _ \    /  _  \     |    \    /    \    |  |    |  |        /  12  \
               | | | |  |  | |  |    | [] /   /   ^  \   |  |    |  |       |    ^   |  
               | |_| |  |  |_|  |    | [] \  /   /\   \  |  |__  |  |__     |9  |-> 3|
               |____/[]  \ ___ /[]   |____/ /__ /  \ __\ |_____| |_____|     \___6__/

Movement has long been used to measure time. For example, the ball clock is a simple device which keeps track of the passing minutes by moving ball-bearings. Each minute, a rotating arm removes a ball bearing from the queue at the bottom, raises it to the top of the clock and deposits it on a track leading to indicators displaying minutes, five-minutes and hours. These indicators display the time between 1:00 and 12:59, but without 'a.m.' or 'p.m.' indicators. Thus 2 balls in the minute indicator, 6 balls in the five-minute indicator and 5 balls in the hour indicator displays the time 5:32.

# Requirements    
                __   __     _     ____     ___   ___  \\  //  
               |  \_/  |   / \   /  __|   /   \  \\ || \\//
               |       |  / _ \ |  |__   | [ ] |  \\   //\\
               |_/\_/\_| /_/ \_\ \____|   \___/ ||_\\ //  \\

  * Ruby -v 2.2.0+ # Use Rvm where possible `rvm install version_number`
  * Install the clock `gem install danno_ball_clock` or clone it from this repo.


# INFO

Valid numbers are in the range 27 to 127.

The Clock supports two modes of computation.

The Clock takes two parameters, the number of balls and the number of minutes to run the Clock for.  If the number of minutes is specified, the clock runs the number of minutes and reports the state of the tracks at that point in a JSON format. If no run time is provided then a JSON format will be returned with the number of days tell ball queue order returns to it's original state.

  Sample Input
  30 325

  Output for the Sample Input
  {"Min":[],"FiveMin":[22,13,25,3,7],"Hour":[6,12,17,4,15],"Main"
  [11,5,26,18,2,30,19,8,24,10,29,20,16,21,28,1,23,14,27,9],"cycleDays":0}

# Using the Gem!

  * `ruby -Ilib ./bin/clock {27,0}` or `ruby -Ilib ./bin/clock {30,325}` # if cloned
  * `ruby -Ilib ~/.rvm/gems/ruby-2.2.3/gems/danno_ball_clock-0.0.3/bin/clock {33,90}` # if installed via `gem install`

# Testing the Gem!

  * `rake` # if cloned
  * `cd ~/.rvm/gems/ruby-2.2.3/gems/danno_ball_clock_0.0.3` then `rake` # if installed via `gem install`
