require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Silencio

  URL_PADRAO = 'http://www.clubesilencio.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO))
    @carousel = page.css('#event-list').css('li')
  end

  def parties
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

      Rails.logger.info "-- BEGIN LOG NOME NA LISTA --"
      Rails.logger.info params
      Rails.logger.info response
      Rails.logger.info "-- END LOG NOME NA LISTA --"
    end
  end

private
  def createFesta (festa)
    Party.new(name(festa), nil, nil, link(festa), image(festa), id(festa))
  end

  def name (festa)
    festa.at_css('.content').css('a').css('img').attribute('alt')
  end

  def link (festa)
    URL_PADRAO
  end

  def image (festa)
    festa.at_css('.content').css('a').css('img').attribute('src')
  end

  def id (festa)
    festa.at_css('.content').attribute('id')
  end
end
