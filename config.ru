require 'rubygems'
require 'bundler'

Bundler.require

require './config/environment'
 
run Dweet #Sinatra::Application
