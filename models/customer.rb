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
