# encoding: utf-8
###
# @author Dan Oberg <dan@cs1.com>
###
require 'rubocop/rake_task'
require 'fasterer'
task :default do
  RuboCop::RakeTask.new
  Fasterer
end

task :run do
  ruby 'init.rb'
end
