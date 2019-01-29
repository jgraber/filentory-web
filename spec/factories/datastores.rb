# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :datastore do
    name { "MyString" }
    mediatype { "" }
  end
end
