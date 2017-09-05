class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word

  def initialize(word)
    @word = word
    @wrong_guesses = ""
    @guesses = ""
  end

  def wrong_guesses
    @wrong_guesses
  end

  def guesses
    @guesses
  end

  def guess(c)
    if c == nil || c == '' || /([a-z])+/i.match(c).to_s != c
      raise ArgumentError
    end
    c.downcase!
    if !@word.include?(c) && !@wrong_guesses.include?(c)
      @wrong_guesses += c
      return true
    elsif !@guesses.include?(c) && @word.include?(c)
      @guesses += c
      return true
    end
    return false
  end

  def word_with_guesses
    s = ""
    @word.each_char { |c|
      if @guesses.include? c
        s += c
      else
        s += "-"
      end
    }
    s
  end

  def check_win_or_lose
    word_set = Set.new @word.chars
    guesses_set = Set.new @guesses.chars
    if @wrong_guesses.length >= 7
      return :lose
    elsif word_set.size == guesses_set.size
      return :win
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
