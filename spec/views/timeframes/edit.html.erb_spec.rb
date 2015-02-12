require 'rails_helper'

RSpec.describe "timeframes/edit", :type => :view do
  before(:each) do
    @timeframe = assign(:timeframe, Timeframe.create!(
      :description => "MyString"
    ))
  end

  it "renders the edit timeframe form" do
    render

    assert_select "form[action=?][method=?]", timeframe_path(@timeframe), "post" do

      assert_select "input#timeframe_description[name=?]", "timeframe[description]"
    end
  end
end
