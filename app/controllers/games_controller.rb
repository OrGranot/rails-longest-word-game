require 'json'
require 'open-uri'

class GamesController < ApplicationController
  ABC = ('A'..'Z').to_a
  def new
    @letters = []
    10.times { @letters << ABC[rand(ABC.size)] }
  end

  def score
    @grid = params[:grid].split(" ")
    @word = params[:word]
    if (!validate_attempt(@word, @grid))
      @message = "Sorry but #{@word} can not be built out of #{@grid.join(' ')}"
    elsif (!is_word_in_dictionary(@word)['found'])
      @message = "Sorry but #{@word} does not seem like a valid English word"
    else @message = "Congratulations! #{@word} is a valid English word"
    end
  end


  private

  def validate_attempt(attempt, grid)
    letters = attempt.upcase.chars
    letters.all? { |letter| letters.count(letter) <= grid.count(letter) }
  end

  def is_word_in_dictionary(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized = URI.open(url).read
    api_result = JSON.parse(serialized)
  end
end
