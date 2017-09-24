require 'rubygems'
require 'bundler/setup'
require 'accuweather'
require 'rainbow'

def wind(w)
  if w == "S"
    return "↓"
  end
  if w == "N"
    return "↑"
  end
  if w =="W"
    return "←"
  end
  if w =="E"
    return "→"
  end
  if ["SW", "WS", "SWS", "SSW", "WSW"].include?(w)
    return "↙";
  end
  if ["WN", "NW", "WNW", "NWN", "WWN", "NNW"].include?(w)
    return "↖";
  end
  if ["NE", "EN", "ENE", "NEN", "EEN","NNE"].include?(w)
    return "↗";
  end
  if ["SE","ES", "ESE", "SSE", "EES", "SES"].include?(w)
    return "↘";
  end
  return w
end

def icon(n)
  n = n.to_i
  icons = {
      5 => "🌞",
      7 => "🌤",
      12 => "🌥",
      15 => "🌧 ☔",
      19 => "⛈ ☔",
  }

  for k, icon in icons
    if n < k
      return icon
     end
  end

  return "🌨 🌬 ❆";
end

# argv-masyv yakyj dopomagae zadavaty (zchytuvaty) z terminalu
#.first- ze pershyj element masyvu
city= ARGV.first

#v masyv lokazii [misto, kraina] my prysvojujemo pershu nazvu mista, jake znahodymo
location_array = Accuweather.city_search(name: city)
location = location_array.first
puts location.city + " " + location.state

# otrymaly dani z Accuweather
response = Accuweather.get_conditions(location_id:location.id, metric: true)

# berem potochnu pogodu
weather = response.current

# masyv dniv prognozy pohody/forcast-to medod zakyj povertae na nastupni dni
weather_forecast = response.forecast

puts Rainbow(" cloud cover: #{weather.cloud_cover}").magenta
puts Rainbow(" humidity: #{weather.humidity}").red
puts Rainbow(" temperature: #{weather.temperature} #{icon(weather.weather_icon)}").orange
puts Rainbow(" wind direction: #{weather.wind_direction}\n\n").aqua



for day in weather_forecast
  puts "#{day.day_of_week}, #{day.date}"
  weather = day.daytime
=begin
  puts ""#{icon(weather.weather_icon)}"
=end
  if weather.wind_direction != nil
    puts Rainbow(" high temperature: #{weather.high_temperature} c°").orange
    puts Rainbow(" low temperature: #{weather.low_temperature} c°").magenta
    puts Rainbow(" precipitation probability: #{weather.precipitation_probability}").aqua
    puts Rainbow(" rain probability: #{weather.rain_probability} ☔").cyan
    puts Rainbow(" wind direction: #{wind(weather.wind_direction)}").blue
  else
    puts " no wind"
  end

  puts Rainbow(" sunrise: #{day.sunrise} 🌞").indianred
  puts Rainbow(" sunset : #{day.sunset} ⛅\n\n").orange
end



