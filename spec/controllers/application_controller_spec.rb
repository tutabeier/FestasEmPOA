require 'spec_helper'
require 'rails_helper'

describe ApplicationController do

  describe "GET #beco" do
    it 'should render :festa view' do
      Party = Struct.new(:name,
                         :date,
                         :hour,
                         :link,
                         :image,
                         :id)
      party = Party.new("Nome festa", "", "", "http://festa.com", "festa.jpg", "01")
      Beco.any_instance.stub(:getParties).and_return(party)

      get :beco
      response.should render_template :festa
    end
  end
  #
  # describe "GET #cdl" do
  #   it "assigns a new Contact to @contact"
  #   it "renders the :new template"
  # end
  #
  # describe "GET #cucko" do
  #   it "assigns a new Contact to @contact"
  #   it "renders the :new template"
  # end
  #
  # describe "GET #silencio" do
  #   it "assigns a new Contact to @contact"
  #   it "renders the :new template"
  # end
  #
  # describe "GET #opiniao" do
  #   it "assigns a new Contact to @contact"
  #   it "renders the :new template"
  # end
end
