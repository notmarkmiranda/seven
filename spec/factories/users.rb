FactoryBot.define do
  factory :user do
    sequence :email{ |x| "john#{x}@johndoe.com" }
    first_name 'John'
    last_name 'Doe'
    password 'password'
  end
end
