require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Cdl

  Party = Struct.new(:name, :link, :image)
  URL_PADRAO = 'https://dl.dropboxusercontent.com/u/35181572/meu_site/'

  def getParties
    fiestas = Array.new

    page = Nokogiri::HTML(open(URL_PADRAO + 'index.html'))
    parties = page.css('#conteudo-home > div')

    parties.each do |festa|
        fiesta = Party.new
        fiesta.name = festa.css('h1').text
        fiesta.link = URL_PADRAO + festa.css('a').attribute('href').value
        fiesta.image = URL_PADRAO + festa.css('img').attribute('src').text.strip

        fiestas.push(fiesta)
    end

    fiestas
  end
end
