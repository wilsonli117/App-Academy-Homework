FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 6) }  

    factory :correct_pw do 
      email { "test@gmail.com" }
      password { "correct" }
    end

  end
end