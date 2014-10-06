class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  def beco
    @festas = Beco.new.getParties
    render "festa"
  end

  def cdl
    @festas = Cdl.new.getParties
    render "festa"
  end

  def cucko
    @festas = Cucko.new.getParties
    render "festa"
  end
end
