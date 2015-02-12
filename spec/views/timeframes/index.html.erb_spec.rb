require 'rails_helper'

RSpec.describe "timeframes/index", :type => :view do
  before(:each) do
    assign(:timeframes, [
      Timeframe.create!(
        :description => "Description"
      ),
      Timeframe.create!(
        :description => "Description"
      )
    ])
  end

  it "renders a list of timeframes" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
