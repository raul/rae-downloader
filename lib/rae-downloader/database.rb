module Database
  extend self

  def connect
    ActiveRecord::Base.establish_connection(RaeDownloader::Config.database_url)
  end

  def clear_active_connections!
    ActiveRecord::Base.clear_active_connections!
  end

  def create
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.create_database(app_connection.fetch(:database))
  end

  def drop
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.drop_database(app_connection.fetch(:database))
  end

  def migrate
    ActiveRecord::Base.establish_connection(app_connection)
    ActiveRecord::Migrator.migrate('db/migrate/')
  end

  def admin_connection
    @@_admin_connection ||= app_connection.merge({ database: 'postgres', schema_search_path: 'public' })
  end

  def app_connection
    @@_app_connection ||= parse_app_connection
  end

  def parse_app_connection
    uri = URI.parse(RaeDownloader::Config.database_url)
    pool_size = RaeDownloader::Config.database_pool_size
    {
      adapter:  uri.scheme == 'postgres' ? 'postgresql' : db.scheme,
      host:     uri.host,
      username: uri.user,
      password: uri.password,
      port:     uri.port || 5432,
      database: uri.path[1..-1],
      encoding: 'UTF-8',
      pool:     pool_size
    }
  end
end

Database.connect
