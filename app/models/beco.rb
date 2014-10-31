require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Beco

  Party = Struct.new(:name, :link, :image)
  URL_PADRAO = 'http://www.beco203.com.br/'

  def getParties
    fiestas = Array.new

    page = Nokogiri::HTML(open(URL_PADRAO+"agenda"))
    parties = page.css('#mycarousel').css('a')

    parties.each do |festa|
      fiesta = Party.new
      fiesta.name = festa.at_css('.baseEventoAgenda').text.strip
      fiesta.link = URL_PADRAO + festa.attributes['href'].value.strip
      #fiesta.image = URL_PADRAO + festa.at_css('.baseAgendaHome').css('img').attribute('src').text.strip
      fiesta.image = nil
      
      fiestas.push(fiesta)
    end

    fiestas
  end
end
