require 'clock'
require 'support/string_extend'
class Guide
  class Config
    @actions = %w[add all exit list new quit]
    def self.actions; @actions; end
  end

  def initialize(path = nil)
    # locate the restarant text file at path
    Clock.filepath = path
    if Clock.file_usable?
      puts 'Found Clock file.'
    # or create a new file
    elsif Clock.create_file
      puts 'Created Clock file.'
    # exit if create fails
    else
      puts "Exiting. \n\n"
      exit!
    end
  end

  def launch!
    introduction
    # action loop
    result = nil
    until result == :quit
      action = current_action
      result = do_action(action)
    end
    conclusion
  end

  def current_action
    action = nil
    until Guide::Config.actions.include?(action)
      puts 'Actions: ' + Guide::Config.actions.join(', ') if action
      print '> '
      user_response = gets.chomp
      action = user_response.downcase.strip
    end
    action
  end

  def do_action(action)
    case action
    when 'list', 'all'
      list
    when 'add', 'new'
      add
    when 'quit', 'exit'
      return :quit
    else
      puts "\nI don't understand that command.\n"
    end
  end

  def list
    output_action_header('Listing ball clocks')
    clocks = Clock.saved_clocks
    output_clock_table(clocks)
  end

  def add
    output_action_header('Add a Clock')
    clock = Clock.build_using_questions
    begin
      clock.save
    rescue => e
      puts "\nSave Error: Clock was not saved!\n"
      puts "\nError: #{e} \n\n"
    else
      puts "\nClock Saved!\n\n"
      puts "Available actions: \'list\', \'add\', \'exit\'."
      list
    end
  end

  def introduction
    puts "\n\n<<< Welcome to Dan\'s Ball Clock Machine >>> \n\n"
    puts "This is an interactive guide to help you tell time since an event\. Type add or new to run your first clock\.\n\n"
    puts "Will tell you when a cycle repeats in day\(s\)\. Or result time of balls in the min\, five minute and hour tracks\.\n\n"
  end

  def conclusion
    puts "\n<<< Tick Tock and Goodbye! >>>\n\n\n"
  end

  private

  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end

  def output_clock_table(clocks = [])
    print "\|" + 'Name'.ljust(30)
    print "\|" + 'Balls'.center(7)
    print "\|" + 'Run Time'.center(10)
    print "\|" + 'Minute Balls'.center(21)
    print "\|" + 'Five Minute Balls'.center(46)
    print "\|" + 'Hour Balls'.center(46)
    print "\|" + 'Cycle Days'.center(12)
    print "\|" + 'Result In JSON'.center(30) + "\|"

    puts "\n" + '_' * 211 + "\n\n"

    clocks.each do |clock|
      line =  ' ' << clock.name.titleize.ljust(30)
      line << "  #{clock.balls}".center(7)
      line << "  #{clock.run_time}".center(10)
      line << "  #{clock.min}".center(21)
      line << "  #{clock.five_min}".center(46)
      line << "  #{clock.hour}".center(46)
      line << "  #{clock.cycle_days}".center(20)
      line << "  #{clock.result}".ljust(30)
      puts "\n"
      puts line
    end

    puts 'No listings found. Type add to get started with your first clock.' if clocks.empty?
    puts "\n" + '_' * 211 + "\n\n"
  end
end
