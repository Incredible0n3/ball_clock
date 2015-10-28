
### Danno's Ball Clock Machine ###
# Copyright Dan Oberg email: dan@cs1.com
#
#
# Launch this Ruby file from the command line to get started.
#
#

APP_ROOT = File.dirname(__FILE__)

# require "#{APP_ROOT}/lib/guide"
# require File.join(APP_ROOT, 'lib', 'guide.rb')
# require File.join(APP_ROOT, 'lib', 'guide')

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'guide'

guide = Guide.new('clocks.txt')
guide.launch!
