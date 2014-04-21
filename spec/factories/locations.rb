# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    path "MyPath"
    name "MyFile"
    last_modified "2014-02-12 21:26:14"
    datastore nil
    datafile nil
  end
end
