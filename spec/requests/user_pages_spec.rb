require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  subject { page }

  describe "signup pages" do
    before { visit sign_up_path }

    it { should have_content('Sign up') }
    it { should have_title("Sign up | Mini Twitter") }
  end

  describe "signup" do
    let(:submit) { "Create my account" }
    before do
      visit sign_up_path 
      ActionMailer::Base.deliveries.clear
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }
        it { should have_title("Sign up") }
        it { should have_content('error') }
        it { should have_content("Name can't be blank") }
        it { should have_content("Email can't be blank") }
        it { should have_content("Email is invalid") }
        it { should have_content("Password can't be blank") }
      end
    end

    describe "sign up a user with valid info" do
      let(:user) { User.new(:name => "inactivated user", :email=>"some@email.com", :password => "foobar") }
      before do
        fill_in "Name",         with: user.name
        fill_in "Email",        with: user.email
        fill_in "Password",     with: user.password
        fill_in "Password confirmation", with: user.password
      end

      it "should create a user" do
        expect{click_button submit}.to change{User.count}.by(1)
        expect(user).to be_truthy
        expect(user.activated).to be false
      end
    end

    describe "activation emails" do
      let(:user) { User.create(:name => "inactivated user", :email=>"some@email.com", :password => "foobar") }
      let(:submit) { "Create my account" }
      before do 
        fill_in "Name",         with: user.name
        fill_in "Email",        with: user.email
        fill_in "Password",     with: user.password
        fill_in "Password confirmation", with: user.password
        click_button submit 
      end

      it "should not activate user with invalid activation token" do
        get edit_account_activation_path("invalid token", email:"some@email.com")
        expect(user.activated).to be false
        expect(session[:user_id]).to eq(nil)
      end

      it "should not activate user for a wrong email" do
        get edit_account_activation_path(user.activation_token, email: "wrong")
        expect(session[:user_id]).to eq(nil)
      end

      it "should activate user with valid activation token and valid user email" do
        get edit_account_activation_path(user.activation_token, email: "some@email.com")
        expect(user.reload.activated).to be true
      end
    end

    describe "sending out activation emails" do
      let(:user) { User.new(:name => "inactivated user", :email=>"some@email.com", :password => "foobar") }
      let(:submit) { "Create my account" }

      before do
        fill_in "Name",         with: user.name
        fill_in "Email",        with: user.email
        fill_in "Password",     with: user.password
        fill_in "Password confirmation", with: user.password 
      end

      it "should create an email when signing up a user" do
        expect {click_button submit}.to change {
            ActionMailer::Base.deliveries.size}.by(1)
      end
    end


  end

  describe "profile page" do
    # Replace with code to make a user variable
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit users_path
    end

    it"renders index page" do
      expect(page.current_path).to eq users_path
    end

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }
      
      it { should have_selector("div.pagination") }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe "delete links" do
      it { should_not have_link('delete') }

      describe "as an admin user" do
        let( :admin ) { FactoryGirl.create(:admin) }
        before do
          visit signin_path
          fill_in "Email",    with: admin.email
          fill_in "Password", with: admin.password
          click_button "Sign in"
          visit users_path
        end

        it "should be able to delete another user" do
          expect do
            click_link("delete", match: :first)
          end.to change(User, :count).by(-1)
        end

        it {should_not have_link('delete', href: user_path(admin)) }
      end
    end



    
  end


end
