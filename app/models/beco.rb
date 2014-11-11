require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Beco < Party

  URL_PADRAO = 'http://www.beco203.com.br/'

  def initialize
    page = Nokogiri::HTML(open(URL_PADRAO+'agenda'))
    @carousel = page.css('#mycarousel').css('a')
  end

  def parties
    festas = Array.new

    @carousel.each do |festa|
      festas.push(createFesta(festa))
    end

    festas.pop(2)
    festas
  end

  def setNomeNaLista(request)
    ids = request['ids'].keys
    nome = request['nome']
    email = request['email']

    ids.each do |id|
      if id != nil
        params = {
          'nome' => nome,
          'email' => email,
          'nomeAmigo1' => "",
          'nomeAmigo2' => "",
          'nomeAmigo3' => "",
          'nomeAmigo4' => "",
          'nomeAmigo5' => "",
          'nomeAmigo6' => "",
          'nomeAmigo7' => "",
          'nomeAmigo8' => "",
          'nomeAmigo9' => "",
          'nomeAmigo10' => "",
          'idAgenda' => id,
          'grava' => "ENVIAR"
        }

        response = Net::HTTP.post_form(URI.parse('http://www.beco203.com.br/resources/files/nomeLista.php?id='+id), params)

        Rails.logger.info "-- BEGIN LOG NOME NA LISTA --"
        Rails.logger.info params
        Rails.logger.info response
        Rails.logger.info "-- END LOG NOME NA LISTA --"
      end
    end
  end

private
  def createFesta (festa)
    Party.new(name(festa), date(festa), hour(festa), link(festa), image(festa), id(festa))
  end

  def name (festa)
    festa.at_css('.baseEventoAgenda').text
  end

  def date (festa)
    festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}\/\d{2}\/\d{4}/).first
  end

  def hour (festa)
    festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}:\d{2}/).first
  end

  def link (festa)
    URL_PADRAO + festa.attributes['href'].value
  end

  def image (festa)
    URL_PADRAO + festa.at_css('.baseAgendaHome').css('img').attribute('src').text
  end

  def id(festa)
    page = Nokogiri::HTML(open(link(festa)))

    unless page.css('.thickbox').css('a').first.nil?
      url = page.css('.thickbox').css('a').first.attributes['href'].value
      uri = URI.parse(url)
      parse = CGI.parse(uri.query)

      id = parse['id'].first
    end

    id
  end
end
