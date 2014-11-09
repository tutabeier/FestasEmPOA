require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Silencio

  Party = Struct.new(:name,
                     :date,
                     :hour,
                     :link,
                     :image)
  URL_PADRAO = 'http://www.clubesilencio.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO))
    @carousel = page.css('#event-list').css('li')
  end

  def getParties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end

    festas
  end

private
  def createFesta (festa)
    Party.new(getName(festa),
              getDate(festa),
              getHour(festa),
              getLink(festa),
              getImage(festa))
  end

  def getName (festa)
    festa.at_css('.content').css('a').css('img').attribute('alt')
  end

  def getDate (festa)
    # festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}\/\d{2}\/\d{4}/).first
  end

  def getHour (festa)
    # festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}:\d{2}/).first
  end

  def getLink (festa)
    URL_PADRAO
  end

  def getImage (festa)
    festa.at_css('.content').css('a').css('img').attribute('src')
  end
end
