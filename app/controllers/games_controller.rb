require "open-uri"
require "json"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << (("A".."Z").to_a).sample
    end
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/"

    @answer = ""
    user_answer = params[:answer].upcase
    @letters = params[:letters].split(" ")

    json = URI.open(url + user_answer).read
    data = JSON.parse(json)

    Rails.logger.info(@answer)
    # puts user_answer
    # puts "-------"
    # p user_answer.split("")
    user_answer.split("").each do |el|
      # p el
      # p "before if:"
      # p @letters
      # p @letters.index(el)
      if @letters.index(el)
        # p "inside if"
        # p el
        # p "before delete: #{@letters}"
        @letters.delete_at(@letters.index(el))
        # p "after delete: #{@letters}"
        @answer = "you win"
      else
        @answer = "This word cannot be made using those letters"
      end
      # puts "---"
    end
    @answer = "Sorry but #{user_answer} does not seem to be a valid English word" unless data["found"] == true
  end
end
