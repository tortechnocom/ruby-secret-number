require 'rubygems'
require 'colorize'

@inputs = Array.new(5)
def main
  puts "Welcome to Secret Number Game, guess number 1 - 50"
  puts "- You can guess 5 times"
  puts "- You can type 'hint' once"
  # puts "- You can type 'secret' for answer"
  puts "# Good Lucky"
  puts "Start..."

  secret_number = rand(1..50)
  compare = false
  use_hint = false
  number_input = ""
  @inputs.each_with_index do |input, index|
    puts "Round [#{index+1}]"
    loop do
      print "Input: "
      number_input = gets.chomp.downcase
      case number_input
      when "hint"
        if use_hint == false
          showHint(secret_number)
        else
          puts "You already used hint.".yellow
        end
        use_hint = true
      when "secret"
        puts "Secret is #{secret_number}".yellow
        break if true
      else
        unless checkInteger(number_input)
          next
        end
        if checkDuplicate(number_input)
          next
        end
        @inputs[index] = number_input
        compare = guess?(secret_number, number_input)
        break if true
      end
    end
    break if compare || number_input == "secret"
  end
  puts "Input History  #{@inputs}".yellow
  unless compare
    puts "Game over! Secret is #{secret_number}".red
  end
end
def guess?(secret_number, number_input)
  compare = secret_number == Integer(number_input)
  if compare
    puts "You are Win.".green
  else
    puts "Sorry, your number isn't secret!".red
  end
  return compare
end
def showHint(secret_number)
  secret_number = secret_number.to_i
  rand_hint = 0
  loop do
    rand_hint = rand(1..10)
    check_start = 1 - rand_hint + secret_number
    check_end = 10 - rand_hint + secret_number
    break if check_start >= 1 && check_end <= 50
  end
  rand_hint_start = 1 - rand_hint + secret_number
  rand_hint_end = 10 - rand_hint + secret_number
  puts "Hint numbers [#{rand_hint_start} - #{rand_hint_end}]".yellow
end
def checkInteger(number_input)
  begin
    number_input_int = Integer(number_input)
    return true
  rescue
    puts "Please enter only number!".yellow
    return false
  end
end
def checkDuplicate(number_input)
  check_duplicate = false
  @inputs.each do |check_input|
    check_duplicate = (check_input == number_input)
    break if check_duplicate
  end
  if check_duplicate
    puts "You already entered #{number_input}. Please try difference.".yellow
  end
  return check_duplicate
end
main if __FILE__ == $0
