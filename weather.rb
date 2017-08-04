require 'rubygems'
require 'bundler/setup'
require 'accuweather'

def icon(n)
  if n > 19
    return "🌨";
  end
end

city= ARGV.first

location_array = Accuweather.city_search(name: city)
location = location_array.first
puts location.city+ "\n"+ location.state

weather = Accuweather.get_conditions(location_id:location.id, metric: true).current
puts "Cloud cover: #{weather.cloud_cover}"
puts "Humidity: #{weather.humidity}"
puts "temperature: #{weather.temperature} #{weather.weather_icon}"
puts "Wind direction: #{weather.wind_direction}"


weather_forecast = Accuweather.get_conditions(location_id: 'cityId:53286').forecast
last_forecast_day = weather_forecast.last
