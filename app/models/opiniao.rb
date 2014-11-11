require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Opiniao < Party

  URL_PADRAO = 'http://www.opiniao.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO))
    @carousel = page.css('.month').css('.clearfix').css('li')
  end

  def parties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end
    festas.delete_if {|element| element.name == "" }
    festas
  end

private
  def createFesta (festa)
    Party.new(name(festa), date(festa), hour(festa), link(festa), image(festa), id(festa))
  end

  def name (festa)
    festa.css('h3').text
  end

  def date (festa)
    day = festa.css('.detail-day').text
    month = festa.css('.detail-month').text
    day + " de " + month
  end

  def hour (festa)
    hour = festa.css('.hour').text
    minute = festa.css('.minute').text
    time = hour + minute
    if time != ""
      time.insert(2, ':')
    end

    time
  end

  def link (festa)
    festa.css('a').first.attribute('href').value
  end

  def image (festa)
    hashImage = Hash[festa.at_css('img').to_a]
    hashImage['src']
  end

  def id(festa)
  end
end
