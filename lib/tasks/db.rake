namespace :db do
  desc "Migrate the db"
  task :migrate do
    Database.migrate
  end

  desc "Create the db"
  task :create do
    Database.create
  end

  desc "Drop the db"
  task :drop do
    Database.drop
  end
end
