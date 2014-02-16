# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	email "JG@JGraber.ch"
  	name "Johnny"
  	password "12345678abc"
  end
end
