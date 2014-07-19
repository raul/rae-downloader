module RaeDownloader
  module Config
    extend self

    def database_pool_size
      ENV["DATABASE_POOL_SIZE"]
    end

    def database_url
      ENV["DATABASE_URL"]
    end
  end
end
