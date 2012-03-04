# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    image = File.new(Rails.root + 'spec/fixtures/images/rails.png')
  end
end
