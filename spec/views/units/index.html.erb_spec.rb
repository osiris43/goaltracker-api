require 'rails_helper'

RSpec.describe "units/index", :type => :view do
  before(:each) do
    assign(:units, [
      Unit.create!(
        :description => "Description"
      ),
      Unit.create!(
        :description => "Description"
      )
    ])
  end

  it "renders a list of units" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
