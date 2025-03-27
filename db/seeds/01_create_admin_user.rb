puts 'Creating users...'

User.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!("users")

user_list = [
  {
    name: 'Karthi',
    email: 'karthis1015@gmail.com',
    password: 'Password$5000',
    phone_number: '9988776655',
    active: true,
    role: 0
  },
  {
    name: 'John',
    email: 'karthis1015+1@gmail.com',
    password: 'Password$5000',
    phone_number: '9897969594',
    age: 25,
    address: "Chennai",
    active: true,
    role: 1
  },
  {
    name: 'David',
    email: 'karthis1015+2@gmail.com',
    password: 'Password$5000',
    phone_number: '9897969595',
    age: 25,
    address: "Chennai",
    active: true,
    role: 2
  }
]

users = User.create(user_list)

puts "admin, orgainizer, and user created..."
