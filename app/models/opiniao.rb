require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Opiniao

  Party = Struct.new(:name,
                     :date,
                     :hour,
                     :link,
                     :image,
                     :id)
  URL_PADRAO = 'http://www.opiniao.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO))
    @carousel = page.css('.month').css('.clearfix').css('li')
  end

  def getParties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end
    festas.delete_if {|element| element.name == "" }
    festas
  end

private
  def createFesta (festa)
    Party.new(getName(festa),
              getDate(festa),
              getHour(festa),
              getLink(festa),
              getImage(festa),
              getId(festa))
  end

  def getName (festa)
    festa.css('h3').text
  end

  def getDate (festa)
    day = festa.css('.detail-day').text
    month = festa.css('.detail-month').text
    day + " de " + month
  end

  def getHour (festa)
    hour = festa.css('.hour').text
    minute = festa.css('.minute').text
    time = hour + minute
    if time != ""
      time.insert(2, ':')
    end

    time
  end

  def getLink (festa)
    festa.css('a').first.attribute('href').value
  end

  def getImage (festa)
    hashImage = Hash[festa.at_css('img').to_a]
    hashImage['src']
  end

  def getId(festa)
  end
end
