# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
cohort1 = Cohort.create!({
  name: 'Cohort One',
  settings: {
    color: 'red'
  }
})

cohort2 = Cohort.create!({
  name: 'Cohort two',
  settings: {
    color: 'Blue'
  }
})

User.create!({
  first_name: 'pam',
  last_name: 'tucker',
  email: 'admin@email.com',
  password: 'password',
  role: 'admin'
})

user1 = User.create!({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: 'password',
  role: 'student',
  user_information: {
    avatar: Faker::Avatar.image("my-own-slug", "50x50"),
    phone: Faker::PhoneNumber.phone_number,
    school: 'West Highschool',
    grade: '11',
    social_media: {
      instagram: 'https://www.instagram.com/graymatterexp/',
      linkedin: 'https://www.linkedin.com/company/the-gray-matter-experience/',
      twitter: 'https://twitter.com/graymatterexp',
      facebook: 'https://www.facebook.com/GrayMatterExp/'
    }
  }
})
user1.cohort_ids = cohort1.id

user2 = User.create!({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: 'password',
  role: 'student',
  user_information: {
    avatar: Faker::Avatar.image("my-own-slug", "50x50"),
    phone: Faker::PhoneNumber.phone_number,
    school: 'West Highschool',
    grade: '11',
    social_media: {
      instagram: 'https://www.instagram.com/graymatterexp/',
      linkedin: 'https://www.linkedin.com/company/the-gray-matter-experience/'
    }
  }
})

user2.cohort_ids = cohort1.id

user3 = User.create!({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: 'password',
  role: 'student',
  user_information: {
    avatar: Faker::Avatar.image("my-own-slug", "50x50"),
    phone: Faker::PhoneNumber.phone_number,
    school: 'West Highschool',
    grade: '11',
    social_media: {
      instagram: 'https://www.instagram.com/graymatterexp/'
    }
  }
})

user2.cohort_ids = cohort2.id

mentor1 = User.create!({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: 'password',
  role: 'mentor',
  user_information: {
    avatar: Faker::Avatar.image("my-own-slug", "50x50"),
    phone: Faker::PhoneNumber.phone_number,
    company: Faker::Company.name,
    specialty: Faker::Company.industry,
    company_logo: Faker::Company.logo,
    social_media: {
      instagram: 'https://www.instagram.com/graymatterexp/'
    }
  }
})

mentor2 = User.create!({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: 'password',
  role: 'mentor',
  user_information: {
    avatar: 'User_Avatar_2.png',
    phone: Faker::PhoneNumber.phone_number,
    company: Faker::Company.name,
    specialty: Faker::Company.industry,
    company_logo: Faker::Company.logo,
    social_media: {
      instagram: 'https://www.instagram.com/graymatterexp/'
    }
  }
})

mentor3 = User.create!({
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: 'password',
  role: 'mentor',
  user_information: {
    avatar: 'User_Avatar_2.png',
    phone: Faker::PhoneNumber.phone_number,
    company: Faker::Company.name,
    specialty: Faker::Company.industry,
    company_logo: Faker::Company.logo,
    social_media: {
      instagram: 'https://www.instagram.com/graymatterexp/'
    }
  }
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

