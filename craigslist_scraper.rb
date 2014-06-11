require 'open-uri'
require 'nokogiri'

def scrape()
  url = "http://www.craigslist.org/about/sites"
  html = open(url).read
  doc = Nokogiri::HTML(html)
  city_and_url = {}
  last_city_name = ""
  states = doc.css(".colmask h4").collect{|e| e.text.strip}.to_enum
  state = states.next
  single_cites = ["delaware", "grand island", "hawaii", "maine", "new hampshire", "northeast SD", "rhode island", "vermont", "washington", "wyoming"]
  puts state
  puts "-----------------------"
  cities = doc.css(".colmask .box ul li a").each do |e|
    if e.text.strip == "guam-micronesia"
      #first non-us city
      break
    end
    city_name = e.text.strip

    url = e["href"].strip
    
    if single_cites.include?(city_name)
      city_name = "washington dc" if city_name == "washington"
      state = states.next
      puts "\n#{state}"
      puts "-----------------------" 
    elsif city_name < last_city_name && city_name != "eastern montana"
      state = states.next
      puts "\n#{state}"
      puts "-----------------------"
    end

    puts city_name
    last_city_name = city_name
    city_and_url[:city] = city_name.downcase
    city_and_url[:url] = url
  end
  puts "\n"
  
  return city_and_url
end