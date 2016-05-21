Gem::Specification.new do |s|
  s.name        = 'danno_ball_clock'
  s.version     = '0.0.3'
  s.date        = %q{2015-10-01}
  s.summary     = "Ball Clock"
  s.description = "A simple ball clock in ruby. Input a number of balls to start with and optionally a run time."
  s.authors     = ["Danial Oberg"]
  s.email       = 'dan@cs1.com'
  s.files       = ["lib/clock.rb", "bin/clock", "test/test_clock.rb", "README.md",
                   ".travis.yml", "Gemfile", "Gemfile.lock"]
  s.executables << 'clock'
  s.homepage    =
    'http://rubygems.org/gems/danno_ball_clock'
  s.license       = 'MIT'
end
