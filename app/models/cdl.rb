require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Cdl < ActiveRecord::Base

  URL_PADRAO = 'https://dl.dropboxusercontent.com/u/35181572/meu_site/'

  def parties
    page = Nokogiri::HTML(open(URL_PADRAO + 'index.html'))
    carousel = page.css('#conteudo-home > div')

    carousel.each do |festa|
      createFesta(festa)
    end
  end

private
  def createFesta (festa)
    cdl = Cdl.new
    cdl.name = getName(festa)
    cdl.date = nil
    cdl.hour = nil
    cdl.link = getLink(festa)
    cdl.image = getImage(festa)
    cdl.id_festa = nil

    cdl.save
  end

  def getName (festa)
    festa.css('h1').text
  end

  def getLink (festa)
    URL_PADRAO + festa.css('a').attribute('href').value
  end

  def getImage (festa)
    URL_PADRAO + festa.css('img').attribute('src').text.strip
  end
end
