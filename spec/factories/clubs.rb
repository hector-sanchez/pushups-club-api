FactoryGirl.define do
  factory :club do
    name { Faker::Lorem.word }
    created_by { Faker::Lorem.word }
  end
end