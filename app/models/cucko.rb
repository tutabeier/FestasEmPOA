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
      paginaFesta = Nokogiri::HTML(open(getLink(festa)))

      festa = Party.new(getName(paginaFesta),
                        getDate(festa),
                        getHour(festa),
                        getLink(festa),
                        getImage(festa))

      festas.push(festa)
    end

    festas
  end

private

  def getName (festa)
    festa.css('#info-evento').css('h1').text
  end

  def getDate (festa)
    nil
  end

  def getHour (festa)
    nil
  end

  def getLink (festa)
    URL_PADRAO + festa.attributes['href'].value
  end

  def getImage (festa)
    URL_PADRAO + festa.css('img').attribute('src').text.strip
  end
end
