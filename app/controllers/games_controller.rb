require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(9)

  end

  def score

    @letter = params[:letters].downcase.chars
    redirect_to '/new' if params[:word] == ''

    letterh = {}
    @letter.each do |l|
      if letterh.has_key?(l)
        letterh[l] += 1
      else
        letterh[l] = 1
      end
    end


    @word = params[:word].downcase.chars
    wordh = {}

    @word.each do |w|
      if wordh.has_key?(w)
        wordh[w] += 1
      else
        wordh[w] = 1
      end
    end

        if english_word?(@word) != true
          @result = "sorry but #{@word} not english"
        elsif wordh <= letterh
          @result = "#{@word} nice word bro"
        else
          @result = "sorry but #{@word} not include at #{@letter}"
        end
  end

  def english_word?(word)
    word_join = word.join()
    response = open("https://wagon-dictionary.herokuapp.com/#{word_join}")

    json = JSON.parse(response.read)
    json['found']

  end
end
