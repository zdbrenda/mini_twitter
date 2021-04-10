require 'rails_helper'


RSpec.describe "UserEdits", type: :request do
    let(:user) {  FactoryGirl.create(:user)}

    describe "when user is logged in " do
        before do
            visit signin_path
            fill_in "Email",    with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
            visit edit_user_path(user)
        end
        describe "edits" do
            describe "when information is incorrectly entered" do
                before do
                    fill_in "Name", with: ""
                    fill_in "Email", with: "" 
                    click_button "Save changes"
                end
                specify { expect(user.reload.name).to eq user.name }
                specify { expect(user.reload.email).to eq user.email }
            end
    
            describe "when information is correctly entered" do
    
                let(:new_name) { "New Name" }
                let(:new_email) { "new@example.com" }
                before do            
                    fill_in "Name",         with: new_name
                    fill_in "Email",        with: new_email
                    click_button "Save changes"
                end
    
                specify { expect(user.reload.name).to eq new_name }
                specify { expect(user.reload.email).to eq new_email }
            end
        end

    end

    describe "when user is not logged in " do
        describe "submitting to the update action with friendly forwarding" do
            before do
                visit edit_user_path(user)
            end

            it "forwards your page to edit page after you log in" do
                sleep 3
                fill_in "Email", with: user.email
                fill_in "Password", with: user.password
                click_button "Sign in"

                expect(page.current_path).to eq edit_user_path(user)
            end

            
        end
    end
    
    describe "as wrong user" do
        
        let(:user) {FactoryGirl.create(:user)}
        let(:wrong_user) {User.create(:name=>"wrong user", :email =>'wrong@gmail.com', 
            :password =>'123456', :password_confirmation => '123456', :activated => true, :activated_at => Time.zone.now)} 

        before do
            visit signin_path
            fill_in "Email",    with: wrong_user.email
            fill_in "Password", with: wrong_user.password
            click_button "Sign in"
        end

        describe "submitting a GET request to the Users#edit action" do
            before { visit edit_user_path(user) }

            it "redirects to root_url" do
                expect(page.current_path).to eq "/"
            end
        end

        describe "submitting a PATCH request to the Users#update action" do

            before do
                page.driver.submit :patch, '/users/user.id', {}
            end
            

            # sleep 3
            # it "redirects to root_url" do
            #     expect(page.current_path).to eq "/"
            # end
        end

    end
end