class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_downcase = @text.downcase.gsub(/[^a-z0-9\s]/i, "")
    special_word_downcase= @special_word.downcase.gsub(/[^a-z0-9\s]/i, "")

    @word_count = @text.split.size

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(/ /, '').length

    @occurrences = text_downcase.split.count(special_word_downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    monthly_apr = @apr/12/100
    months = @years * 12

    @monthly_payment = (monthly_apr*@principal)/(1-(1+monthly_apr)**(-months))

    #(monthly_apr*@principal) ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/1.minute
    @hours = @minutes/60.0
    @days = @hours/24.0
    @weeks = @days/7.0
    @years = @weeks/52.0

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    square_sum=[]

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    sorted = @sorted_numbers
    len = sorted.length
    @median = (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0

    @sum = @numbers.inject(:+)

    @mean = @sum/@count

    sorted.each do |n|
      square = (n - @mean)**2
      square_sum.push(square)
    end
    square_sum = square_sum.inject(:+)
    @variance = square_sum/@count

    @standard_deviation = @variance**0.5

    @mode =

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
