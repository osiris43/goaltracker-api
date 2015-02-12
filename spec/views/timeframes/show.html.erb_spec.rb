require 'rails_helper'

RSpec.describe "timeframes/show", :type => :view do
  before(:each) do
    @timeframe = assign(:timeframe, Timeframe.create!(
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
  end
end
