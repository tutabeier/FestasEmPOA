require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Opiniao < ActiveRecord::Base

  URL_PADRAO = 'http://www.opiniao.com.br/'

  def parties
    page = Nokogiri::HTML(open(URL_PADRAO))
    carousel = page.css('.month').css('.clearfix').css('li')

    carousel.each do |festa|
      if (getName(festa) != "")
        createFesta(festa)
      end
    end
  end

  private
  def createFesta (festa)
    opiniao = Opiniao.new
    opiniao.name = getName(festa)
    opiniao.date = getDate(festa)
    opiniao.hour = getHour(festa)
    opiniao.link = getLink(festa)
    opiniao.image = getImage(festa)
    opiniao.id_festa = nil

    opiniao.save
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
end
