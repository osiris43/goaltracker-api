require 'rails_helper'

RSpec.describe "goals/show", :type => :view do
  before(:each) do
    @goal = assign(:goal, Goal.create!(
      :activity => nil,
      :unit => nil,
      :timeframe => nil,
      :measurement => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
