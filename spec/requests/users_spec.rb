require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryGirl.create(:user) }


  it "should return false for a user with nil digest" do
    expect(user.authenticated?(' ')).to be(false)
  end

  
end
