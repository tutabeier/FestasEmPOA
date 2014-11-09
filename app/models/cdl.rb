require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Cdl

  Party = Struct.new(
                      :name,
                      :date,
                      :hour,
                      :link,
                      :image)
  URL_PADRAO = 'https://dl.dropboxusercontent.com/u/35181572/meu_site/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO + 'index.html'))
    @carousel = page.css('#conteudo-home > div')
  end

  def getParties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end

    festas
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
    festa.css('h1').text
  end

  def getDate (festa)
    nil
  end

  def getHour (festa)
    nil
  end

  def getLink (festa)
    URL_PADRAO + festa.css('a').attribute('href').value
  end

  def getImage (festa)
    URL_PADRAO + festa.css('img').attribute('src').text.strip
  end
end
