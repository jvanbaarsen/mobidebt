FactoryGirl.define do

  factory :user do
    email "info@example.com"
    name 'John Doe'
    password 'secret'
    salt "asdasdasdasd1234adsasd"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("secret", "asdasdasdasd1234adsasd")
    credits 10
  end
end

