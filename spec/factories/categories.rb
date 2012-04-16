# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name_fr){|n| "categorie_#{n}" }
    sequence(:name_en){|n| "category_#{n}" }
  end
end
