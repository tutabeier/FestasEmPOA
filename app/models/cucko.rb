require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Cucko

  Party = Struct.new(
                      :name,
                      :date,
                      :hour,
                      :link,
                      :image)
  URL_PADRAO = 'http://www.cucko.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO+"agenda"))
    @carousel = page.css('#agenda').css('a')
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
    nil
  end

  def getDate (festa)
    nil
  end

  def getHour (festa)
    nil
  end

  def getLink (festa)
    URL_PADRAO + festa.attributes['href'].value.strip
  end

  def getImage (festa)
    URL_PADRAO + festa.css('img').attribute('src').text.strip
  end
end
