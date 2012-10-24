# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    group nil
    user nil
    secret "MyString"
  end
end
