namespace :db do
  desc "for copying production database to local development database"
  task :copy_production => :environment do |t|
    database = Rails.configuration.database_configuration['development']['database']
    puts "Dropping '#{database}'"
    `dropdb #{database}`
    puts "Getting production database to #{database}"
    `time heroku pg:pull DATABASE_URL #{database} --app vis-imp`
    puts "completed."
  end

  desc "for copying local development database to production"
  task :copy_development_to_production => :environment do |t|
    database = Rails.configuration.database_configuration['development']['database']
    cmd = "time heroku pg:reset DATABASE_URL --app vis-imp --confirm vis-imp"
    puts "Resetting production database."
    puts "\t#{cmd}"
    `#{cmd}`
    cmd2 = "time heroku pg:push #{database} DATABASE_URL --app vis-imp"
    puts "Replacing production database with data from #{database}"
    puts "\t#{cmd2}"
    `#{cmd2}`
    puts "completed."
  end
end
