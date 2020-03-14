require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :genre, :screening

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['id']
    @genre = options['genre']
    @screening = options['screning']
  end

  def save()
    sql = "INSERT INTO films
    (
    title,
    genre,
    screening
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@title, @genre, @screening]
    film_data = SqlRunner.run(sql, values).first
    @id = film_data['id'].to_i
  end
end
