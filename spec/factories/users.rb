# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "email#{n}@emiliesatre.com" }
    sequence(:full_name){|n| "full_name#{n}" }
    password 'foobar'
  end

  factory :admin, :parent => :user do
    admin true
  end
end
