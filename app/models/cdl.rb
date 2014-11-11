require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Cdl < Party

  URL_PADRAO = 'https://dl.dropboxusercontent.com/u/35181572/meu_site/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO + 'index.html'))
    @carousel = page.css('#conteudo-home > div')
  end

  def parties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end

    festas
  end

  def Parties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end

    festas
  end

private
  def createFesta (festa)
    Party.new(name(festa), nil, nil, link(festa), image(festa), nil)
  end

  def name (festa)
    festa.css('h1').text
  end

  def link (festa)
    URL_PADRAO + festa.css('a').attribute('href').value
  end

  def image (festa)
    URL_PADRAO + festa.css('img').attribute('src').text.strip
  end
end
