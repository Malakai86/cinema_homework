require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :genre, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (
    title,
    genre,
    price
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@title, @genre, @price]
    film_data = SqlRunner.run(sql, values).first
    @id = film_data['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (
    title,
    genre,
    price
    ) = (
      $1, $2, $3
      )
      WHERE id = $4"
      values = [@title, @genre, @price]
      SqlRunner.run(sql, values)
    end

    def customers()
      sql = "SELECT customers.*
      FROM customers
      INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
      values = [@id]
      customer_data = SqlRunner.run(sql, values)
      return Customer.map_items(customer_data)
    end

    def viewers()
      sql = "SELECT customers.*
      FROM customers
      INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
      values = [@id]
      customer_data = SqlRunner.run(sql, values)
      return Customer.map_items(customer_data).count
    end

    def delete()
      sql = "DELETE FROM films
      WHERE id = $1"
      values = ['id']
      SqlRunner.run(sql, values)
    end

  def self.all()
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    return Film.map_items(film_data)
  end


  def self.map_items(film_data)
    result = film_data.map {|film| Film.new(film)}
    return result
  end

end
