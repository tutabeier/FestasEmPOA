require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Beco

  Party = Struct.new(:name,
                     :date,
                     :hour,
                     :link,
                     :image)
  URL_PADRAO = 'http://www.beco203.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO+'agenda'))
    @carousel = page.css('#mycarousel').css('a')
  end

  def getParties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end

    festas.pop(2)
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
    festa.at_css('.baseEventoAgenda').text
  end

  def getDate (festa)
    festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}\/\d{2}\/\d{4}/).first
  end

  def getHour (festa)
    festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}:\d{2}/).first
  end

  def getLink (festa)
    URL_PADRAO + festa.attributes['href'].value
  end

  def getImage (festa)
    URL_PADRAO + festa.at_css('.baseAgendaHome').css('img').attribute('src').text
  end
end
