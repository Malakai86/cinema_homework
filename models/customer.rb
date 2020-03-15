require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :cash

def initialize(options)
  @id = options['id'] if options['id']
  @name = options['name']
  @cash = options['cash']
end

def save()
  sql = "INSERT INTO customers
  (
    name,
    cash
    )
    VALUES
    (
      $1, $2
    )
  RETURNING id"
  values = [@name, @cash]
  customer = SqlRunner.run(sql, values).first
  @id = customer['id'].to_i
end

def films()
  sql = "SELECT films.* FROM
  films INNER JOIN
  tickets ON
  tickets.film_id = films.id WHERE customer_id = $1"
  values = [@cash]
end

def update()
  sql = "UPDATE customers SET (
  name,
  cash
  ) = (
    $1, $2
    )
    WHERE id = $3"
    values = [@name, @cash]
    SqlRunner.run(sql, values)
  end

def films()
  sql = "SELECT films.* FROM
  films INNER JOIN
  tickets ON
  tickets.film_id = films.id WHERE customer_id = $1"
  values = [@id]
  film_data = SqlRunner.run(sql, values)
  return Film.map_items(film_data)
end

def tickets()
  sql = "SELECT films.* FROM
  films INNER JOIN
  tickets ON
  tickets.film_id = films.id WHERE customer_id = $1"
  values = [@id]
  film_data = SqlRunner.run(sql, values)
  return Film.map_items(film_data).count
end


def buying()
  sql = "SELECT price FROM films WHERE id = $1"
  values = [@id]
  price_data = SqlRunner.run(sql, values)
  return price_data.map{|price| Film.new(price)}
end

def buy()
  price = self.films()
  price_cost = films.map{|film| film.price}
  cost = price_cost.sum
  return @cash - cost
end

def delete()
  sql = "DELETE FROM customers
  WHERE id = $1"
  values = ['id']
  SqlRunner.run(sql, values)
end



def self.all()
  sql = "SELECT * FROM customers"
  customer_data = SqlRunner.run(sql)
  return Customer.map_items(customer_data)
end

def self.map_items(customer_data)
  result = customer_data.map { |customer| Customer.new(customer)}
  return result
end

end
