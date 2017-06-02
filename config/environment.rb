require 'bundler' #bundler is a built in class in ruby, installs required gems
Bundler.require #runs the bundler class from above


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
# ActiveRecord::Migration.verbose = false

require_all 'lib'
require_all 'app/models'
