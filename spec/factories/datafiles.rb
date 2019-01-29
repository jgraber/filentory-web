# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :datafile do
    name { "MyString" }
    checksum { "MyString" }
    size { 1 }
  end
end
