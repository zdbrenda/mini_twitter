require 'rails_helper'

RSpec.describe "AuthenticationPages", type: :request do
  subject { page }
  describe "signin page" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title("Sign in") }
      it { should have_selector('div.alert.alert-danger') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector("div.alert.alert-danger") }
      end
    end

    describe "with valid information followed by logout" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",      with: user.email.upcase
        fill_in "Password",   with: user.password
        click_button "Sign in"
      end

      it { should have_link('Profile',      href: user_path(user)) }
      it { should have_link('Sign out',     href: signout_path) }
      it { should have_link('Settings'),    href: edit_user_path(user) }
      it { should_not have_link( 'Sign in', href: signin_path) }
      it { should have_link("Users",        href: users_path) }
      
      describe "followed by signout" do
        before do
          click_link "Sign out" 
          delete signout_path
        end
        it { should have_link("Sign in")}
        it { should_not have_link("Sign out")}
      end

    end

    it { should have_content("Sign in") }
    it { should have_title("Sign in") }
  end


end
