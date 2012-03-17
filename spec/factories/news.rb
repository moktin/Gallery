# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news do
    title 'Super title'
    content 'Super Content'
    start_at DateTime.now
  end
end
