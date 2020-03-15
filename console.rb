require_relative('models/customer')
require_relative('models/ticket')
require_relative('models/film')

require('pry-byebug')

customer1 = Customer.new({ 'name' => 'Jim', 'cash' => 100})
customer1.save()

customer2 = Customer.new({ 'name' => 'Kate', 'cash' => 70})
customer2.save()

customer3 = Customer.new({ 'name' => 'Steve', 'cash' => 40})
customer3.save()

film1 = Film.new({ 'title' => 'Brave Heart', 'genre' => 'action', 'screening' => 2045})
film1.save()

film2 = Film.new({ 'title' => 'Fight Club', 'genre' => 'thriller', 'screening' => 1915})
film2.save()

film3 = Film.new({ 'title' => 'Scream', 'genre' => 'horror', 'screening' => 1915})
film3.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id, 'price' => 15})
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'price' => 20})
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film1.id, 'price' => 10})
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film3.id, 'price' => 5})
ticket4.save()

binding.pry
nil
