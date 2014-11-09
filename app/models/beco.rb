require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Beco

  Party = Struct.new(
                      :name,
                      :date,
                      :hour,
                      :link,
                      :image)
  URL_PADRAO = 'http://www.beco203.com.br/'

  def getParties
    fiestas = Array.new

    page = Nokogiri::HTML(open(URL_PADRAO+'agenda'))
    parties = page.css('#mycarousel').css('a')

    parties.each do |festa|
      fiesta = Party.new
      fiesta.name = festa.at_css('.baseEventoAgenda').text
      fiesta.date = festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}\/\d{2}\/\d{4}/).first
      fiesta.hour = festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}:\d{2}/).first
      fiesta.link = URL_PADRAO + festa.attributes['href'].value
      fiesta.image = URL_PADRAO + festa.at_css('.baseAgendaHome').css('img').attribute('src').text

      fiestas.push(fiesta)
    end

    fiestas.pop(2)
    fiestas
  end
end
