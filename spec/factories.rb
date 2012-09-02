
FactoryGirl.define do
  factory :todo do
    name 'Go shopping'
    description 'You can go with your akbil'
    starred false
  end
  factory :user do
    email 'test@forgething.com'
    password 'forgething'
    password_confirmation 'forgething'
  end
  factory :tag do
    name 'Work'
  end
  factory :authentication do
    provider 'twitter'
    uid '123456'
  end
end

