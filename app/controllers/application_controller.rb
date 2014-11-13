class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  def beco
    @festas = Beco.all
    @casa = 'beco'
    render 'festa'
  end

  def cdl
    @festas = Cdl.all
    render 'festa'
  end

  def cucko
    @festas = Cucko.all
    @casa = 'cucko'
    render 'festa'
  end

  def silencio
    @festas = Silencio.all
    @casa = 'silencio'
    render 'festa'
  end

  def opiniao
    @festas = Opiniao.all
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

  def formAll
    Beco.new.setNomeNaLista(request.POST)
    Cucko.new.setNomeNaLista(request.POST)
    Silencio.new.setNomeNaLista(request.POST)
    render 'done'
  end
end
