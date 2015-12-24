require 'rails_helper'

RSpec.describe "routing to events", :type => :routing do
  it "routes / to events#index" do
    expect(:get => "/").to route_to(
      :controller => "events",
      :action => "index"
    )
  end

  it "routes /events/:id to events#update" do
    expect(:put => "/events/1").to route_to(
      :controller => "events",
      :action => "update",
      :id => "1"
    )
  end
end
