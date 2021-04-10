FactoryGirl.define do
    factory :user do
        sequence(:name) { |n| "Person #{n}" }
        sequence(:email) { |n| "person_#{n}@gmail.com"}
        password "foobar"
        password_confirmation "foobar"
        activated true
        activated_at Time.zone.now
        factory :admin do
            admin true
    end
    factory :inactivated_user do
        name "inactivated user"
        email "some@gmail.com"
        password "foobar"
        password_confirmation "foobar"
    end
    
    end
end