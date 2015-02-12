require 'rails_helper'

RSpec.describe "goals/index", :type => :view do
  before(:each) do
    assign(:goals, [
      Goal.create!(
        :activity => nil,
        :unit => nil,
        :timeframe => nil,
        :measurement => 1
      ),
      Goal.create!(
        :activity => nil,
        :unit => nil,
        :timeframe => nil,
        :measurement => 1
      )
    ])
  end

  it "renders a list of goals" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
