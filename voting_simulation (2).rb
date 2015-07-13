class Campaign
  attr_accessor :votes_republican, :votes_democrat, :candidates, :voters

  def initialize(candidates, voters)
    @vote_total_republican = 0
    @vote_total_democrat = 0
    @candidates = candidates
    @voters = voters
  end


  def voter_selection
    @voters.each do |v|
      case v.politics
      when "Libertarian"
        if rand(1..100) <= 90
         v.vote_for = "Republican"
        else
          v.vote_for = "Democrat"
        end
      when "Conservative"
        if rand(1..100) <= 75
          v.vote_for = "Republican"
        else
          v.vote_for = "Democrat"
        end
      when "Independent"
        if rand(1..100) <= 50
          v.vote_for = "Republican"
        else
          v.vote_for = "Democrat"
        end
      when "Progressive"
        if rand(1..100) <= 25
          v.vote_for = "Republican"
        else
          v.vote_for = "Democrat"
        end
      when "Massachusetts Democrat"
        if rand(1..100) <= 10
          v.vote_for = "Republican"
        else
          v.vote_for = "Democrat"
        end
      end
    end
  end

  def count_votes
    @voters.each do |v|
      if v.vote_for == "Republican"
        @vote_total_republican += 1
      else
        @vote_total_democrat += 1
      end

    end
  end

  def winner
    tabulating = ["...", "Tabulating!", "Tabulating!", "Tabulating!" "..."]
    puts tabulating.cycle(1) {|counting| puts counting; sleep 1}
    if @vote_total_republican > @vote_total_democrat
      puts "The Republicans Win! It was finally time for a change!"
    else
      puts "The Democrats Win! Another four years with a Democratic President :) "
    end
  end
end
