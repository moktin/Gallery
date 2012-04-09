# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    sequence(:name){|n| "page_#{n}" }
    content 'content'
  end
end
