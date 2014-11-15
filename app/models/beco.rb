require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Beco < ActiveRecord::Base

  URL_PADRAO = 'http://www.beco203.com.br/'

  def parties
    page = Nokogiri::HTML(open(URL_PADRAO+'agenda'))
    carousel = page.css('#mycarousel').css('a')

    carousel.each do |festa|
      createFesta(festa)
    end

    lastTwo = Beco.last(2)
    Beco.delete(lastTwo)
  end

  def setNomeNaLista(request)
    ids = Beco.pluck(:id_festa)
    nomes = request['nome'].values
    emails = request['email'].values
    lista = Hash[nomes.zip emails].delete_if { |nome, email| nome.nil? || email.nil? || nome.empty? || email.empty? }

    lista.each do |nome, email|
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

          # response = Net::HTTP.post_form(URI.parse('http://www.beco203.com.br/resources/files/nomeLista.php?id='+id.to_s), params)

          Rails.logger.info "Adicionado nome " + nome + " e email " + email + " na lista do Beco."
        end
      end
    end
  end

  private
  def createFesta (festa)
    beco = Beco.new
    beco.name = getName(festa)
    beco.date = getDate(festa)
    beco.hour = getHour(festa)
    beco.link = getLink(festa)
    beco.image = getImage(festa)
    beco.id_festa = getIdFesta(festa)

    beco.save
  end

  def getName (festa)
    festa.at_css('.baseEventoAgenda').text
  end

  def getDate (festa)
    festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}\/\d{2}\/\d{4}/).first
  end

  def getHour (festa)
    festa.at_css('.baseEventoDataAgenda').text.scan(/\d{2}:\d{2}/).first
  end

  def getLink (festa)
    URL_PADRAO + festa.attributes['href'].value
  end

  def getImage (festa)
    URL_PADRAO + festa.at_css('.baseAgendaHome').css('img').attribute('src').text
  end

  def getIdFesta(festa)
    page = Nokogiri::HTML(open(getLink(festa)))

    unless page.css('.thickbox').css('a').first.nil?
      url = page.css('.thickbox').css('a').first.attributes['href'].value
      uri = URI.parse(url)
      parse = CGI.parse(uri.query)

      id = parse['id'].first
    end

    id
  end
end
