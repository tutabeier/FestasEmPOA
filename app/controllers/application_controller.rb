class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  def beco
    @festas = Beco.new.getParties
    @casa = 'beco'
    render 'festa'
  end

  def cdl
    @festas = Cdl.new.getParties
    render 'festa'
  end

  def cucko
    @festas = Cucko.new.getParties
    @casa = 'cucko'
    render 'festa'
  end

  def silencio
    @festas = Silencio.new.getParties
    @casa = 'silencio'
    render 'festa'
  end

  def opiniao
    @festas = Opiniao.new.getParties
    render 'festa'
  end

  def formBeco
    Beco.new.setNomeNaLista(request.POST)
    render 'done'
  end

  def formCucko
    Cucko.new.setNomeNaLista(request.POST)
    render 'done'
  end

  def formSilencio
    Silencio.new.setNomeNaLista(request.POST)
    render 'done'
  end
end
