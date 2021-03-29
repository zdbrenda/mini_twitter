require 'rails_helper'
require 'webdrivers'


RSpec.describe StaticPagesController, type: :request do
    def setup
        @base_title = "Mini Twitter"
    end

    describe "Root page" do
        before { visit root_path }

        it "should get root" do
            expect(page).to have_http_status(:ok)
        end
    
        it "should get root" do
            expect(page).to have_title("#{@base_title}")
        end
    end

    describe "About page" do 
        before { visit about_path  }
        it "should return About page for /about" do
            expect(page).to have_http_status(:ok)
        end
    
        it "should return About page for /about" do
            expect(page).to have_title("About | #{@base_title}")
        end     
    end

    describe "Contact page" do
        before {   visit contact_path }
        it "should return About page for /contact" do
            expect(page).to have_http_status(:ok)
        end
    
        it "should return About page for /contact" do
            expect(page).to have_title("Contact | #{@base_title}")
        end
    end
    
end