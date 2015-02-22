require 'rails_helper'

RSpec.describe "units/edit", :type => :view do
  before(:each) do
    @unit = assign(:unit, Unit.create!(
      :description => "MyString"
    ))
  end

  it "renders the edit unit form" do
    render

    assert_select "form[action=?][method=?]", unit_path(@unit), "post" do

      assert_select "input#unit_description[name=?]", "unit[description]"
    end
  end
end
