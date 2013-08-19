require 'sinatra'
require 'twitter'
require 'pg'
require 'active_record'
require 'erb'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

require './config/config'
require './config/database'

require './app'




