# Blackjack game (object oriented version)
#
# 2013.9.11

class Card                          # ex. ['Dimond','6']
  attr_accessor :suit, :face_value, :value

  def initialize(suit, face_value, value)
    @suit       = suit
    @face_value = face_value
    @value      = value
  end
end

class Deck 
  attr_accessor :cards

  def initialize(n=1)
    setup n
  end

  def shuffle!
    cards.shuffle!
  end
  
  def deal
    cards.pop    
  end

  def size
    cards.size
  end

  def setup n
    @cards = []
    suits = ['spades', 'hearts', 'dimonds', 'clubs']
    cards = [ ['2', 2], ['3', 3], ['4', 4], ['5', 5], ['6', 6], ['7', 7], ['8', 8], ['9', 9], ['10', 10], ['J', 10], ['Q', 10], ['K', 10], ['A', 11 ]]
    suits.product(cards).each do |arr|                    # ['clubs', ['A', 11]]] ......
      @cards << Card.new(arr[0], arr[1][0], arr[1][1])    # ['clubs', 'A', 11] format
    end 
    @cards = @cards * n    # n decks of cards
    shuffle! 
  end
end

class Person
  attr_accessor :cards, :hit, :sum, :busted

  def initialize
    @cards = []   
    @hit = true    # hit or stay
    @sum = 0
    @busted = false
  end

  def add_card(card)
    cards << card
  end

  def calculate_sum
    sum = 0
    cards.each do |card|
      sum = sum + card.value
    end
    cards.select{|card| card.face_value == 'A' }.count.times do  # correction of "A" if sum > Blackjack::BLACKJACK_AMOUNT
      sum -= 10 if sum > Blackjack::BLACKJACK_AMOUNT      
    end
    return sum
  end

end

class Dealer < Person
  attr_reader :name

  def initialize
    super
    @name = 'Dealer'    
  end  
end
  
class Player < Person
  attr_accessor :name

  def initialize
    super
    @name = ''    
  end  
end

class Blackjack
  attr_accessor :deck, :dealer, :player

  DECK_AMOUNT = 5
  MINIMUN_CARDS_IN_DECK = 10
  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize   
    @deck = Deck.new( DECK_AMOUNT )
    @dealer = Dealer.new
    @player = Player.new
  end

  def set_player_name
    puts 'Welcome to the Black Jack Game!'
    puts 'What is your name?'
    player.name = gets.chomp
  end

  def deal_cards
    2.times do 
      dealer.add_card(deck.deal)
      player.add_card(deck.deal)
    end
  end

  def show_card cards     
    cards.each do |card|
      puts "  #{card.suit}  #{card.face_value}"
    end
  end

  # Show the dealer and player information on screen
  #
  def screen_show  
    puts "-----------------------------------"
    puts "The dealer's cards are:"
    show_card dealer.cards
    puts "The dealer's sum is: #{dealer.calculate_sum}"
    puts "-----------------------------------"
    puts "#{player.name}, your cards are:"
    show_card player.cards  
    puts "Your sum is: #{player.calculate_sum}"
    puts "==================================="
  end

  def player_turn    
    while player.hit && !player.busted
      dealer.sum =  dealer.calculate_sum
      player.sum =  player.calculate_sum
      screen_show   

      if ( player.sum == BLACKJACK_AMOUNT ) || ( dealer.sum == BLACKJACK_AMOUNT )
        player.hit = false
        dealer.hit = false
      else 
        puts "#{player.name}, Would you like to hit or stay? (h/s)"
        response = gets.chomp
        if  response == 'h'
          player.add_card(deck.deal)
          player.sum = player.calculate_sum 
          player.busted = true if player.sum > BLACKJACK_AMOUNT 
        elsif ( response == 's' ) || ( player.sum == BLACKJACK_AMOUNT )
          player.hit = false
        end
      end
    end
    screen_show
  end 

  def dealer_turn
    while dealer.hit && !dealer.busted && !player.busted     
      while ( dealer.sum < DEALER_HIT_MIN ) && !dealer.busted
        dealer.add_card(deck.deal)           # dealer deals card 
        dealer.sum =  dealer.calculate_sum
        dealer.busted = true if dealer.sum > BLACKJACK_AMOUNT
        puts "        The dealer deals!"
        
        dealer.sum =  dealer.calculate_sum
        player_sum =  player.calculate_sum
        screen_show 
      end
      dealer.hit = false if dealer.sum >= DEALER_HIT_MIN  
    end    
  end

  def judge_winner
    if player.busted 
      result = "#{player.name}, You busted, the dealer wins!"
    elsif dealer.busted
      result = "The dealer busted! #{player.name}, you win!" 
    elsif ( player.sum == BLACKJACK_AMOUNT ) && ( dealer.sum == BLACKJACK_AMOUNT )
      result = "It's a tie!"
    elsif ( player.sum == BLACKJACK_AMOUNT ) || ( player.sum > dealer.sum ) 
      result = "#{player.name}, you win!"
    elsif ( dealer.sum == BLACKJACK_AMOUNT ) || ( dealer.sum > player.sum )
      result = "The dealer wins!"
    else
      result = "It's a tie!"
    end 
    puts result
  end

  def play_again?
    puts "#{player.name}, Would you like to quit the game? (y/n)"
  
    response = ''
    while !["y","n"].include?(response)
      response = gets.chomp
      if response == 'y'
        play = false
        puts "Have a nice day! #{player.name}"
      elsif response == 'n'
        dealer.cards.clear
        player.cards.clear
        dealer.sum = 0
        player.sum = 0
        player.hit = true
        dealer.hit = true
        player.busted = false 
        dealer.busted = false
        start     # restart the game recursively
      else
        puts "Please enter 'y' or 'n'." 
      end
    end      
  end

  def start
    set_player_name if player.name == ''   
    deck.setup DECK_AMOUNT if deck.size <= MINIMUN_CARDS_IN_DECK  # redo the deck if size is too small    
    deal_cards    
    player_turn
    dealer_turn
    judge_winner
    play_again? 
  end

  
end

game = Blackjack.new
game.start



