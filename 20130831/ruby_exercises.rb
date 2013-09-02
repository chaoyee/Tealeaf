# Note: we're looking for Ruby commands for the below questions, not the actual answers, unless it's a question. 
#
# Hint: you can type "irb" in your terminal to get a Ruby console to test things out. For multi-line code, use an editor that can run Ruby code, or copy/paste into irb.
#
# Hint 2: you can refer to the Ruby doc for Array and Hash here: 
#
# http://www.ruby-doc.org/core-1.9.3/Array.html
# http://www.ruby-doc.org/core-1.9.3/Hash.html
#
#
# 1. Use the "each" method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value.
#
puts "------ Q.1 ----------"
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

arr.each do |a|
	puts "#{a}"
end 

# 2. Same as above, but only print out values greater than 5.
#
puts "------ Q.2 ----------"
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each do |a|
	puts "#{a}" if a > 5 
end 

# 3. Now, using the same array from #2, use the "select" method to extract all odd numbers into a new array.
#
puts "------ Q.3 ----------"
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
new_arr = arr.select do |a|
	a > 5
end
puts new_arr

# 4. Append "11" to the end of the array. Prepend "0" to the beginning.
#
puts "------ Q.4 ----------"
arr.push 11
arr.unshift 0
puts arr

# 5. Get rid of "11". And append a "3".
#
puts "------ Q.5 ----------"
arr.pop
arr.push 3
puts arr
# 6. Get rid of duplicates without specifically removing any one value. 
#
puts "------ Q.6 ----------"
puts arr.uniq

=begin

  7. What's the major difference between an Array and a Hash?
  Ans: The hash uses key and value, both can be any value.
       The array is a special case of the hash, of which the key must be integer.

       Also, hashes do no provide order, while arrays do.  

=end

# 8. Create a Hash using both Ruby 1.8 and 1.9 syntax.
#
#    Suppose you have a h = {a:1, b:2, c:3, d:4}
#
puts "--------- Q.8 -----------"

puts "---- Ruby 1.8 syntax ----"
h = {:a => 1, :b => 2, :c => 3, :d => 4}
puts h

puts "---- Ruby 1.9 syntax ----"
h2 = {a:1, b:2, c:3, d:4}
puts h2

# 9. Get the value of key "b".
#
puts "--------- Q.9 -----------"
puts h[:b]

# 10. Add to this hash the key:value pair {e:5}
#
puts "--------- Q.10 ----------"
h[:e] = 5 
puts h

# 13. Remove all key:value pairs whose value is less than 3.5
#
puts "--------- Q.13 ----------"
h.each do |k,v|
	h.delete(k) if v < 3.5
end
puts h

# 14. Can hash values be arrays? Can you have an array of hashes? (give examples)
#
puts "--------- Q.14 ----------"
puts "The answer is yes."
h[:f] = [0, 1, 2, 3, 'abc']
h[:g] = [7, 8, 9, {x: ['pig','chiken','sheep'], y: ['tiger','lion'], z: ['black', 666]}]
arr.push h

puts arr
puts '-----------------'
puts arr[12][:g][3][:y][1]

=begin
15. Look at several Rails/Ruby online API sources and say which one your like best and why.

Ans: It's the .times API.  Because if you using 5.times, it really iterates five times.
     It's really like normal English that we speak.
=end  
