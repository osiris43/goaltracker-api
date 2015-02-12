require 'rails_helper'

RSpec.describe "units/show", :type => :view do
  before(:each) do
    @unit = assign(:unit, Unit.create!(
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
  end
end
