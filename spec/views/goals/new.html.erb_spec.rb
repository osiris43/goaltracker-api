require 'rails_helper'

RSpec.describe "goals/new", :type => :view do
  before(:each) do
    assign(:goal, Goal.new(
      :activity => nil,
      :unit => nil,
      :timeframe => nil,
      :measurement => 1
    ))
  end

  it "renders new goal form" do
    render

    assert_select "form[action=?][method=?]", goals_path, "post" do

      assert_select "input#goal_activity_id[name=?]", "goal[activity_id]"

      assert_select "input#goal_unit_id[name=?]", "goal[unit_id]"

      assert_select "input#goal_timeframe_id[name=?]", "goal[timeframe_id]"

      assert_select "input#goal_measurement[name=?]", "goal[measurement]"
    end
  end
end
