require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Silencio

  Party = Struct.new(:name,
                     :date,
                     :hour,
                     :link,
                     :image,
                     :id)
  URL_PADRAO = 'http://www.clubesilencio.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO))
    @carousel = page.css('#event-list').css('li')
  end

  def getParties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end

    festas
  end

  def setNomeNaLista(request)
    ids = request['ids']
    nome = request['nome']
    email = request['email']

    ids.each do |id, nomeEvento|
      params = {
        'nome' => nome,
        'email' => email,
        'nome_amigo[]' => "",
        'nome_amigo[]' => "",
        'nome_amigo[]' => "",
        'nome_amigo[]' => "",
        'nome_amigo[]' => "",
        'evento' => nomeEvento,
        'eventoId' => id
      }

      response = Net::HTTP.post_form(URI.parse('http://www.clubesilencio.com.br/nome_na_lista_data/nomeLista'), params)
      Rails.logger.info response
    end
  end

private
  def createFesta (festa)
    Party.new(getName(festa),
              getDate(festa),
              getHour(festa),
              getLink(festa),
              getImage(festa),
              getId(festa))
  end

  def getName (festa)
    festa.at_css('.content').css('a').css('img').attribute('alt')
  end

  def getDate (festa)
  end

  def getHour (festa)
  end

  def getLink (festa)
    URL_PADRAO
  end

  def getImage (festa)
    festa.at_css('.content').css('a').css('img').attribute('src')
  end

  def getId (festa)
    festa.at_css('.content').attribute('id')
  end
end
