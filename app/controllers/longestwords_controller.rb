require 'open-uri'
require 'json'

class LongestwordsController < ApplicationController
  def game
    @grid = generate_grid(9)
  end

  def home

  end
  def score
    @grid1 = params[:wordgrid]
    @start_time = Time.now
    @end_time = Time.now
    @attempt = params[:wordsend]
    @result = run_game(@attempt, @grid1, @start_time, @end_time)
    @score = @result[:score]
    @message = @result[:message]
  end

  def generate_grid(grid_size)
  # TODO: generate random grid of letters
  arr = []
  i = 0
  while i < grid_size
    arr << [*"A".."Z"].sample
    i += 1
  end
  arr
end

def english_word?(word)
  res = "https://wagon-dictionary.herokuapp.com/" + word
  hash = JSON.parse(open(res).read)
  hash["found"]
end

def lettergrid?(word, grid)
  # return false if word.size > grid.size
  word.upcase!
  bl = true
  word.each_char do |let|
    if !grid.include?(let)
      return false
    else
      grid.slice!(grid.index(let))
    end
  end
  return bl
end

def run_game1(my_hash, attempt, grid, start_time, end_time)
  my_hash[:score] = 0
  if !english_word?(attempt)
    my_hash[:message] = "not an english word"
  elsif !lettergrid?(attempt, grid)
    my_hash[:message] = "not in the grid"
  else
    my_hash[:message] = "Message: Well Done!"
    my_hash[:score] = attempt.size * (100 - (end_time - start_time))
  end
  return my_hash
end

def run_game(attempt, grid, start_time, end_time)
  my_hash = {}
  my_hash = run_game1(my_hash, attempt, grid, start_time, end_time)
  my_hash[:time] = end_time - start_time
  return my_hash
end

end
