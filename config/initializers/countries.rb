require 'httparty'

raw = HTTParty.get('https://restcountries.com/v3.1/all?fields=name')
data = JSON.parse(raw.body)

COUNTRIES = data
  .select { |c| c.is_a?(Hash) && c['name'].is_a?(Hash) }
  .map { |c| c['name']['common'] }
  .compact.uniq.sort


