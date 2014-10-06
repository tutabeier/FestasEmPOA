require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Cucko

  Party = Struct.new(:name, :link, :image)
  URL_PADRAO = 'http://www.cucko.com.br/'

  def getParties
    fiestas = Array.new

    page = Nokogiri::HTML(open(URL_PADRAO+"agenda"))
    parties = page.css('#agenda').css('a')

    parties.each do |festa|
      fiesta = Party.new
      fiesta.name = nil
      fiesta.link = URL_PADRAO + festa.attributes['href'].value.strip
      fiesta.image = URL_PADRAO + festa.css('img').attribute('src').text.strip

      fiestas.push(fiesta)
    end

    fiestas
  end
end
