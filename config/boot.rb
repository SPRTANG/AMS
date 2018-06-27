ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
require File.expand_path('../initializers/debug_require', __FILE__)
require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
