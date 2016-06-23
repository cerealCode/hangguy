#https://github.com/saasbook/hw-sinatra-saas-hangperson/blob/master/docs/part_4_cucumber.md

class HangpersonGame
   
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = '' 
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess (char)  

    if char == '' or char.nil?
      raise ArgumentError
    end

    #char.match(/[A-Za-z]/) ? char.downcase! : raise ArgumentError 
    if char.match(/[A-Za-z]/)
      char.downcase! 
    else
      raise ArgumentError 
    end
     
    if @guesses.include? char or @wrong_guesses.include? char
      return false
    end

    @word[char] ? @guesses += char : @wrong_guesses += char 

  end  
   

  def word_with_guesses
    @word.gsub(/[^ #{@guesses}]/, '-')    
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    elsif word_with_guesses == @word
      return :win
    else
      return :play
    end
  end

end
