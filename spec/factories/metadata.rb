# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :metadata, :class => 'Metadata' do
    key "MyString"
    value "MyString"
    datafile nil
  end
end
