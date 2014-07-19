require "bundler/setup"
Bundler.require

require_relative "rae-downloader/config"
require_relative "rae-downloader/database"
require_relative "rae-downloader/word"
require_relative "rae-downloader/word_definer_worker"
