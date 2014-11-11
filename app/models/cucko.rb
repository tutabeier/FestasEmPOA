require 'rubygems'
require 'open-uri'
require 'nokogiri'
require "uri"
require "net/http"

class Cucko

  URL_PADRAO = 'http://www.cucko.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO+"agenda"))
    @carousel = page.css('#agenda').css('a')
  end

  def parties
    festas = Array.new

    @carousel.each do |festa|
      paginaFesta = Nokogiri::HTML(open(link(festa)))

      party = Party.new(name(paginaFesta), nil, nil, link(festa), image(festa), id(festa))

      festas.push(party)
    end

    festas
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
  def name (festa)
    festa.css('#info-evento').css('h1').text
  end

  def link (festa)
    URL_PADRAO + festa.attributes['href'].value
  end

  def image (festa)
    URL_PADRAO + festa.css('img').attribute('src').text.strip
  end

  def id (festa)
    link(festa).split('/').last
  end
end
