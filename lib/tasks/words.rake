namespace :words do
  desc "Outputs the data for a given word"
  task :show, :word do |t, args|
    puts "Usage: rake words:show[<WORD>]"
    if word = RaeDownloader::Word.find_by_word(args[:word])
      puts "Data for #{word}:"
      puts word.pretty_definition
    else
      puts "#{args[:word]} not found"
    end
  end

  desc "Schedules undefined words to be defined"
  task :schedule do
    RaeDownloader::Word.undefined.find_each.each do |word|
      puts "Scheduling #{word} to be defined"
      RaeDownloader::WordDefiner.perform_async(word.id)
    end
  end

  desc "Insert missing words from lemario.txt into the database"
  task :seed do
    words = File.readlines("./data/lemario.txt").map{ |w| w.strip }
    puts "Inserting #{words.size} words into the database."
    words.each{ |w| RaeDownloader::Word.create(word: w) }
  end

  desc "Displays statistics about the words in the database"
  task :stats do
    total = RaeDownloader::Word.count
    undefined = RaeDownloader::Word.undefined.count
    undefined_perc = 100.0 * undefined.to_f / RaeDownloader::Word.count
    msg = <<-TXT
There are #{total} words in the database.
#{undefined} of them (a #{"%0.5f" % undefined_perc}%) aren't defined yet.
    TXT
    puts msg
  end
end
