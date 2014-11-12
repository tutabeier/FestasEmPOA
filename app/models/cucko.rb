require 'rubygems'
require 'open-uri'
require 'nokogiri'
require "uri"
require "net/http"

class Cucko < ActiveRecord::Base

  URL_PADRAO = 'http://www.cucko.com.br/'

  def parties
    page = Nokogiri::HTML(open(URL_PADRAO+"agenda"))
    carousel = page.css('#agenda').css('a')

    carousel.each do |festa|
      paginaFesta = Nokogiri::HTML(open(getLink(festa)))

      cucko = Cucko.new
      cucko.name = getName(paginaFesta)
      cucko.date = nil
      cucko.hour = nil
      cucko.link = getLink(festa)
      cucko.image = getImage(festa)
      cucko.id_festa = getIdFesta(festa)

      cucko.save
    end
  end

  def setNomeNaLista(request)
    ids = request['ids'].keys
    puts ids
    nome = request['nome']
    email = request['email']
    ids.each do |id|
      params = {
        'nome[]' => nome,
        'email' => email,
        'idEvento' => id
      }
      response = Net::HTTP.post_form(URI.parse('http://www.cucko.com.br/nome_lista/gravaNomeLista'), params)
      Rails.logger.info "-- BEGIN LOG NOME NA LISTA --"
      Rails.logger.info params
      Rails.logger.info response
      Rails.logger.info "-- END LOG NOME NA LISTA --"
    end
  end

private
  def getName (festa)
    festa.css('#info-evento').css('h1').text
  end

  def getLink (festa)
    URL_PADRAO + festa.attributes['href'].value
  end

  def getImage (festa)
    URL_PADRAO + festa.css('img').attribute('src').text.strip
  end

  def getIdFesta (festa)
    getLink(festa).split('/').last
  end
end
