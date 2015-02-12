require 'rails_helper'

RSpec.describe "timeframes/new", :type => :view do
  before(:each) do
    assign(:timeframe, Timeframe.new(
      :description => "MyString"
    ))
  end

  it "renders new timeframe form" do
    render

    assert_select "form[action=?][method=?]", timeframes_path, "post" do

      assert_select "input#timeframe_description[name=?]", "timeframe[description]"
    end
  end
end
