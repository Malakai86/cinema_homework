require_relative('models/customer')
require_relative('models/ticket')
require_relative('models/film')

require('pry-byebug')

customer1 = Customer.new({ 'name' => 'Jim', 'cash' => 100})
customer1.save()

customer2 = Customer.new({ 'name' => 'Kate', 'cash' => 70})
customer2.save()

film1 = Film.new({ 'title' => 'Brave Heart', 'genre' => 'action', 'screening' => 2045})
film1.save()

film2 = Film.new({ 'title' => 'Fight Club', 'genre' => 'thriller', 'screening' => 1915})
film2.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})

binding.pry
nil
