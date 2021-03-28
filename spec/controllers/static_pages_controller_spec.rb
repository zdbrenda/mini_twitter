require 'rails_helper'
require 'webdrivers'


RSpec.describe StaticPagesController, type: :request do
    def setup
        @base_title = "Mini Twitter"
    end
    
    it "should return home page for /home" do
        visit '/static_pages/home'
        expect(page).to have_http_status(:ok)
    end

    it "should have the title Home" do
        visit '/static_pages/home'
        expect(page).to have_title("Home | #{@base_title}")
    end


    it "should return About page for /about" do
        visit '/static_pages/about'
        expect(page).to have_http_status(:ok)
    end

    it "should return About page for /about" do
        visit '/static_pages/about'
        expect(page).to have_title("About | #{@base_title}")
    end

    it "should return About page for /contact" do
        visit '/static_pages/contact'
        expect(page).to have_http_status(:ok)
    end

    it "should return About page for /contact" do
        visit '/static_pages/contact'
        expect(page).to have_title("Contact | #{@base_title}")
    end




    
end