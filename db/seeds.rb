# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if User.count == 0 
  User.create!(username: 'Женя', email: 'seventhstar@mail.ru', password: 'password', password_confirmation: 'password') if Rails.env.development?
end

if Currency.count==0  
  Currency.create([{name: 'RUB', short: 'руб.', code: '643'},
   {name: 'USD', short: '$', code: '840'},
   {name: 'EUR', short: '€', code: '978'}, ])
end
