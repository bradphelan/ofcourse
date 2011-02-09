# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# compass integration
require 'sass/plugin/rack'
use Sass::Plugin::Rack
require "fileutils"
cssdir = File.expand_path("../tmp/stylesheets/compiled", __FILE__)
cachedir = File.expand_path("../tmp/sass-cache", __FILE__)
FileUtils.mkdir_p(cssdir)
FileUtils.mkdir_p(cachedir)

use Rack::Static, :urls => ["/stylesheets/compiled"], :root => "tmp"

Sass::Plugin.options[:css_location] = cssdir
Sass::Plugin.options[:cache_location] = cachedir
Sass::Plugin.options[:template_location] = File.expand_path("../sass", __FILE__) 

# Seems to do the job to get compass going though
# we are not using Rails
require 'compass'
require 'susy' 
require 'compass/app_integration/rails'

Compass::AppIntegration::Rails.initialize!

run Ofcourse::Application
