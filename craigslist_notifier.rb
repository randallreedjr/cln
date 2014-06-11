require_relative 'craigslist_scraper.rb'

def run()
  city_urls = scrape()
  puts "Please select city:"
  city_name = gets.chomp

  if city_urls[city_name.downcase]
    puts city_urls[city_name.downcase]
  end
end

run()

