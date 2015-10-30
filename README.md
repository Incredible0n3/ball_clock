  [![Build Status](https://travis-ci.org/Incredible0n3/ball_clock.svg)](https://travis-ci.org/Incredible0n3/ball_clock)
  [![Code Climate](https://codeclimate.com/github/Incredible0n3/ball_clock/badges/gpa.svg)](https://codeclimate.com/github/Incredible0n3/ball_clock)
  [![Test Coverage](https://codeclimate.com/github/Incredible0n3/ball_clock/badges/coverage.svg)](https://codeclimate.com/github/Incredible0n3/ball_clock/coverage)
  [![Documentation](http://img.shields.io/badge/docs-rdoc.info-blue.svg)](http://www.rubydoc.info/github/Incredible0n3/ball_clock)



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
  * sdl2 # Use homebrew `brew doctor` then `brew install sdl2`
  * Install Bundler `gem install bundler` then `bundle`


# INFO

Valid numbers are in the range 27 to 127.

The Clock must supports two modes of computation.

The Clock takes two parameters, the number of balls and the number of minutes to run for.  If the number of minutes is specified, the clock runs the number of minutes and reports the state of the tracks at that point in a JSON format. If no run time is provided then a JSON format will be returned with the number of days tell ball queue order returns to it's original state.

  Sample Input
  30 325

  Output for the Sample Input
  {"Min":[],"FiveMin":[22,13,25,3,7],"Hour":[6,12,17,4,15],"Main"
  [11,5,26,18,2,30,19,8,24,10,29,20,16,21,28,1,23,14,27,9],"cycleDays":0}

# Getting Started!

Run `rake run` from the command line.

Once the app is running. Your available actions are [add, new, list, all, quit, exit].

`Add` or `New` Will start the process of adding a new clock. You will be prompted with a some questions to get going. Run time is optional. Will show results when complete from the local `.txt` file in a table.

`All` or `List` Shows the results in a table format.

`exit` or `quit` Exits the program with a message.