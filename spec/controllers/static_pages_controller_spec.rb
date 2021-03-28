require 'rails_helper'



RSpec.describe StaticPagesController, :type => :controller do
    it "should return home page for /home" do
        # static_pages_controller=StaticPagesController.new
        # home=static_pages_controller.home
        get :home
        expect(response).to have_http_status(:ok)
        
    end

    it "should return help page for /help" do
        get :help
        expect(response).to have_http_status(:ok)
        
    end

    it "should return About page for /about" do
        # static_pages_controller=StaticPagesController.new
        # about=static_pages_controller.about
        get :about
        expect(response).to have_http_status(:ok)
        
    end
    
end