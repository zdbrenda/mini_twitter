FactoryGirl.define do
    factory :user do
        name "Brenda"
        email "brenda@gmail.com"
        password "foobar"
        password_confirmation "foobar"
    end
end