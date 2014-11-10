require 'rubygems'
require 'open-uri'
require 'nokogiri'
require "uri"
require "net/http"

class Cucko

  Party = Struct.new(:name,
                     :date,
                     :hour,
                     :link,
                     :image,
                     :id)
  URL_PADRAO = 'http://www.cucko.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO+"agenda"))
    @carousel = page.css('#agenda').css('a')
  end

  def getParties
    festas = Array.new

    @carousel.each do |festa|
      paginaFesta = Nokogiri::HTML(open(getLink(festa)))

      festaStruct = Party.new(getName(paginaFesta),
                        getDate(festa),
                        getHour(festa),
                        getLink(festa),
                        getImage(festa),
                        getId(festa))

      festas.push(festaStruct)
    end

    festas
  end

  def setNomeNaLista(request)
    ids = request['ids']
    nome = request['nome']
    email = request['email']

    ids.each do |id|
      params = {
        'nome[]' => nome,
        'email' => email,
        'idEvento' => id
      }

      response = Net::HTTP.post_form(URI.parse('http://www.cucko.com.br/nome_lista/gravaNomeLista'), params)
      Rails.logger.info response
    end
  end

private
  def getName (festa)
    festa.css('#info-evento').css('h1').text
  end

  def getDate (festa)
  end

  def getHour (festa)
  end

  def getLink (festa)
    URL_PADRAO + festa.attributes['href'].value
  end

  def getImage (festa)
    URL_PADRAO + festa.css('img').attribute('src').text.strip
  end

  def getId (festa)
    getLink(festa).split('/').last
  end
end
