# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

User.create!({
  first_name: 'pam',
  last_name: 'tucker',
  email: 'admin@email.com',
  password: 'password',
  role: 'admin'
})

20.times do 
  event = Event.new
  event.title = Faker::Book.title
  start = Faker::Time.between(1.months.ago, Date.today + 2.months, :morning)
  event.start = start
  event.end = Faker::Time.between(start, start + 2.days, :evening)
  event.color = ['black','green','red', nil].sample
  event.save
end

