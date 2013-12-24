# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  db_name = ENV['DB'] || 'postgres'
  database_yml = File.expand_path('../database.yml', __FILE__)
  ActiveRecord::Base.configurations = YAML.load_file(database_yml)
  config = ActiveRecord::Base.configurations[db_name]

  ActiveRecord::Base.establish_connection(db_name)

  ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__), 'debug.log'))
  ActiveRecord::Base.default_timezone = :utc

  ActiveRecord::Migration.verbose = false
  load(File.join(File.dirname(__FILE__), 'schema.rb'))

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end