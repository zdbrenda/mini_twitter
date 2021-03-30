require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  subject { page }

  describe "User pages" do
    before { visit sign_up_path }

    it { should have_content('Sign up') }
    it { should have_title("Sign up | Mini Twitter") }
  end
end
