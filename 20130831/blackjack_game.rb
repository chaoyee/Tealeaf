######################################################
#
#  Black Jack Game
#
#  2013/9/3
#
#
######################################################

# To display a deck of cards. ex. [["clubs A"], 11]
#
def show_card cards     
	cards.each do |s,c,v|
		puts "  #{s}  #{c}"
	end
end

# To calculate the total sum of cards.
#
def calculate_sum deck
	sum = 0
	deck.each do |s,c,v|
		sum += v
	end
	deck.select{|s,c,v| c == "A"}.count.times do  # correction of "A" if sum > 21
		if sum > 21
			sum -= 10
		end	
	end	
	return sum
end

#============================================================
# Assemble the deck and assign the value to eack card
#
# suits = spades (♠), hearts (♥), diamonds (♦) and clubs (♣).
#
suits = ["spades", "hearts", "dimonds", "clubs"]
cards = [ ["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6], ["7", 7], ["8", 8], ["9", 9], ["10", 10], ["J", 10], ["Q", 10], ["K", 10], ["A", 11 ]]
deck = []
deck_temp2 = []
deck_temp1 = suits.product(cards)                # ["clubs", ["A", 11]]] ......
deck_temp1.each do |k, arr|                      # Transfer deck_temp to ["clubs", "A", 11] format
	deck_temp2 << [k, arr[0], arr[1]] 
end

4.times do                                       # Multiple decks to prevent card counting
	deck_temp2.each do |s,c,v|
		deck << [s,c,v]
	end 
end

dealer_cards = []
player_cards = []
dealer_sum = 0
player_sum = 0
player_hit = true
dealer_hit = true 
player_busted = false
dealer_busted = false
play = true

puts "Welcome to the Black Jack Game!"
puts "What is your name?"
name = gets.chomp

# Main program
#
while play 
		2.times { deck.shuffle! }
		2.times do                        # Initial deal
			dealer_cards << deck.pop
			player_cards << deck.pop
		end
	while player_hit && ( player_busted == false )    # player part
		puts "-----------------------------------"
		puts "The dealer's cards are:"
		show_card dealer_cards
		dealer_sum = calculate_sum dealer_cards
		puts "The dealer's sum is: #{dealer_sum}"
		puts "-----------------------------------"
		puts "#{name}, your cards are:"
		show_card player_cards	
		player_sum = calculate_sum player_cards
		puts "Your sum is: #{player_sum}"
		puts "==================================="

		if ( player_sum == 21 ) || ( dealer_sum == 21 )
			player_hit = false
			dealer_hit = false
		else 
			puts "#{name}, Would you like to hit or stay? (h/s)"
			response = gets.chomp
			if  response == 'h'
				player_cards << deck.pop
				player_sum = calculate_sum player_cards
				player_busted = true if player_sum > 21 
			elsif ( response == 's' ) || ( player_sum == 21 )
				player_hit = false
			end
		end
	end	
	puts "-----------------------------------"
	puts "The dealer's cards are:"
	show_card dealer_cards
	dealer_sum = calculate_sum dealer_cards
	puts "The dealer's sum is: #{dealer_sum}"
	puts "-----------------------------------"
	puts "#{name}, your cards are:"
	show_card player_cards	
	player_sum = calculate_sum player_cards
	puts "Your sum is: #{player_sum}"
	puts "==================================="

	while dealer_hit && ( dealer_busted == false ) && ( player_busted == false )   # dealer part
		while ( dealer_sum < 17 ) && ( dealer_busted == false )
			dealer_cards << deck.pop          # dealer deals card  
			dealer_sum = calculate_sum dealer_cards
			dealer_busted = true if dealer_sum > 21	
			puts "        The dealer deals!"

			puts "-----------------------------------"
			puts "The dealer's cards are:"
			show_card dealer_cards
			dealer_sum = calculate_sum dealer_cards
			puts "The dealer's sum is: #{dealer_sum}"
			puts "-----------------------------------"
			puts "#{name}, your cards are:"
			show_card player_cards	
			player_sum = calculate_sum player_cards
			puts "Your sum is: #{player_sum}"
			puts "==================================="
	
		end
		dealer_hit = false if dealer_sum >= 17 	
	end

	if player_busted 
		result = "#{name}, You are busted, the dealer wins!"
	elsif dealer_busted
		result = "The dealer is busted! #{name}, you win!"	
	elsif ( player_sum == 21 ) && ( dealer_sum == 21 )
		result = "It's a draw game!"
	elsif ( player_sum == 21 ) || ( player_sum > dealer_sum ) 
		result = "#{name}, you win!"
	elsif ( dealer_sum == 21 ) || ( dealer_sum > player_sum )
		result = "The dealer wins!"
	else
		result = "It's a draw game!"
	end 

	puts result
	
	puts "#{name}, Would you like to quit the game? (y/n)"
	if gets.chomp == 'y'
		play = false
		puts "Have a nice day! #{name}"
	else
		dealer_cards.clear
		player_cards.clear
		dealer_sum = 0
		player_sum = 0
		play = true
		player_hit = true
		dealer_hit = true
		player_busted = false 
		dealer_busted = false 
    end
end
