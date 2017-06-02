require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  Pry.start
end

desc 'Starts a new basketball game'
task :playball do
  system "ruby bin/run.rb"
end
