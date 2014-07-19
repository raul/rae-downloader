module RaeDownloader
  class Word < ActiveRecord::Base
    validates :word, presence: true, uniqueness: true

    scope :defined, -> { where('defined_at IS NOT NULL') }
    scope :undefined, -> { where('defined_at IS NULL') }

    def define
      json = HTTPRae.new.search(word)
      update_attributes data: json, defined_at: Time.now
    end

    def to_s
      word
    end

    def pretty_definition
      JSON.pretty_generate(data) if defined_at
    end
  end
end
