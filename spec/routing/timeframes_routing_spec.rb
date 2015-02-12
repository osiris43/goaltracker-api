require "rails_helper"

RSpec.describe TimeframesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/timeframes").to route_to("timeframes#index")
    end

    it "routes to #new" do
      expect(:get => "/timeframes/new").to route_to("timeframes#new")
    end

    it "routes to #show" do
      expect(:get => "/timeframes/1").to route_to("timeframes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/timeframes/1/edit").to route_to("timeframes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/timeframes").to route_to("timeframes#create")
    end

    it "routes to #update" do
      expect(:put => "/timeframes/1").to route_to("timeframes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/timeframes/1").to route_to("timeframes#destroy", :id => "1")
    end

  end
end
