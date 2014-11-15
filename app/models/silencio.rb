require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Silencio < ActiveRecord::Base

  URL_PADRAO = 'http://www.clubesilencio.com.br/'

  def parties
    page = Nokogiri::HTML(open(URL_PADRAO))
    carousel = page.css('#event-list').css('li')

    carousel.each do |festa|
      createFesta(festa)
    end
  end

  def setNomeNaLista(request)
    ids = Silencio.pluck(:id_festa)
    lista = cleanHash (request)

    lista.each do |nome, email|
      ids.each do |id, nomeEvento|
        params = {
          'nome' => nome,
          'email' => email ,
          'nome_amigo[]' => "",
          'nome_amigo[]' => "",
          'nome_amigo[]' => "",
          'nome_amigo[]' => "",
          'nome_amigo[]' => "",
          'evento' => nomeEvento,
          'eventoId' => id
        }

        # response = Net::HTTP.post_form(URI.parse('http://www.clubesilencio.com.br/nome_na_lista_data/nomeLista'), params)

        Rails.logger.info "Adicionado nome " + nome + " e email " + email + " na lista do Clube Silencio."
      end
    end
  end

  private
  def cleanHash (request)
    nomes = request['nome'].values
    emails = request['email'].values
    Hash[nomes.zip emails].delete_if { |nome, email| nome.nil? || email.nil? || nome.empty? || email.empty? }
  end

  def createFesta (festa)
    silencio = Silencio.new
    silencio.name = getName(festa)
    silencio.date = nil
    silencio.hour = nil
    silencio.link = getLink(festa)
    silencio.image = getImage(festa)
    silencio.id_festa = getIdFesta(festa)

    silencio.save
  end

  def getName (festa)
    festa.at_css('.content').css('a').css('img').attribute('alt').text
  end

  def getLink (festa)
    URL_PADRAO
  end

  def getImage (festa)
    festa.at_css('.content').css('a').css('img').attribute('src').text
  end

  def getIdFesta(festa)
    festa.at_css('.content').attribute('id')
  end
end
