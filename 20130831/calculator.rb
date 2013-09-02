#  Calculator 
#
#  2013/9/2
#

puts "Please input the first number:" 
num1 = gets.chomp
puts "Please input the second number:"
num2 = gets.chomp

puts "What operation do yo want to perform?"
puts " 1)add" 
puts " 2)sub"
puts " 3)multiply"
puts " 4)div"

operator = gets.chomp

if operator == '1'
		result = num1.to_i + num2.to_i
	elsif operator == '2'
		result = num1.to_i - num2.to_i
	elsif operator == '3'
		result = num1.to_i * num2.to_i
	elsif operator == '4'
		result = num1.to_f / num2.to_f
end

puts "The result is: #{result}"				

