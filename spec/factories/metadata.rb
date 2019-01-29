# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :metadata, :class => 'Metadata' do
    key "MyString"
    value "MyString"
    datafile nil
  end
end
