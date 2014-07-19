module RaeDownloader
  class WordDefiner
    include Sidekiq::Worker

    def perform(word_id)
      w = Word.find(word_id)
      unless w.defined_at
        logger.info "Defining #{w}"
        w.define
      end
    end
  end
end
