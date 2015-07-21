require './voter'
require './candidate'
require './voting_simulation'

class VoterSim
  attr_accessor :candidate_array, :voter_array

  def initialize
    @candidate_array = []
    @voter_array = []
  end

  def invalid_choice
        puts "Please enter a valid choice!"
  end

  def intro
      puts "Welcome to the voting simulator. What would you like to do?"
  end

  def display_choices
      puts <<-END
      Select from the given choices:
      --(C)reate
      --(L)ist
      --(U)pdate
      --(V)ote
      --(E)xit
      END
  end

  def main_menu_user_choice
      user_choice = gets.chomp.downcase
      case user_choice
      when "c"
        puts <<-END
        Would you like to create a voter or candidate?
        Select from the given choices:
        --(C) Candidate
        --(V) Voter
        END
        character_choice = gets.chomp.downcase
          case character_choice
          when "c"
            make_candidate
          when "v"
            make_voter
          else
            puts "That is not a valid entry. Please try again."
            main_menu_user_choice
          end

      when "l"
        puts <<-END
        What list do you want to view?
        --(C)andidate list
        --(V)oter list
        END
        user_list = gets.chomp.downcase
        case user_list
        when "c"
          space
          list_c
        when "v"
          space
          list_v
        else
          puts "That is not a valid entry. Please try again."
          main_menu_user_choice
        end
      when "u"
        puts <<-END
        Who would you like to update?
        --(C)andidate
        --(V)oter
        END
        group_select = gets.chomp.downcase
          case group_select
          when "c"
            list_c
            update_candidate
          when "v"
            list_v
            update_voter
          else
            puts "That is not a valid entry. Please try again."
            main_menu_user_choice
          end
      when "v"
        campaign = Campaign.new(@candidate_array, @voter_array)
        campaign.voter_selection
        campaign.count_votes
        campaign.winner
      when "e"
        exit_game
      else
        puts "That is not a valid entry. Please try again."
        main_menu_user_choice
      end
  end

  def make_candidate
    puts "Please enter your name"
    name = gets.chomp.capitalize
    puts <<-END
    Choose your party:
    --(D)emocrat
    --(R)epublican
    END
    party = gets.chomp.downcase
    case party
    when "d"
      name = Candidate.new(name,"Democrat")
    when "r"
      name = Candidate.new(name, "Republican")
    else
      puts "That is not a valid entry. Please try again."
      make_candidate
    end
      @candidate_array << name
  end

  def make_voter
    puts "Please enter your name?"
    name = gets.chomp.capitalize
    puts <<-END
    Which are your political views?
    --(P)rogressive
    --(C)onservative
    --(L)ibertarian
    --(M)assachusetts Democrat
    --(I)ndependent
    END
    politics = gets.chomp.downcase
    case politics
    when "p"
      name = Voter.new(name, "Progressive")
      # @voter_array.push name
    when "c"
      name = Voter.new(name, "Conservative")
      # @voter_array.push name
    when "l"
      name = Voter.new(name, "Libertarian")
    when "m"
      name = Voter.new(name, "Massachusetts Democrat")
      # @voter_array.push name
    when "i"
      name = Voter.new(name, "Independent")
      # @voter_array.push name
    else
      puts "That is not a valid entry. Please try again."
      main_menu_user_choice
    end
      @voter_array.push name
  end

  def list_v
    @voter_array.each { |x|
    print x.name.capitalize + "-"
    puts x.politics}
    space
  end

  def list_c
    @candidate_array.each { |x|
    print x.name.capitalize + "-"
    puts x.party}
    space
  end

  def space
    puts " "
  end

  def update_candidate
    puts "Enter name exactly as shown"
    candidate_name = gets.chomp.capitalize
    @candidate_array.each do |c|
    if c.name == candidate_name
        puts "I found it, please enter new name"
        new_name = gets.chomp
        puts <<-END
        What is your new desired party?:
        --(D)emocrat
        --(R)epublican
        END
        party = gets.chomp.downcase
        case party
        when "d"
          c.party = "Democrat"
        when "r"
          c.party = "Republican"
        end
        c.name = new_name
        puts "Update Complete."
        space
        print c.name.capitalize + "-"
        puts c.party
      else
        puts "That is not a valid candidate."
        update_candidate
    end
  end
  end

  def exit_game
    puts "Thanks for trying our Voter Sim, goodbye!"
    exit(0)
  end


  def update_voter
    puts "Enter name exactly as shown"
    voter_name = gets.chomp.capitalize
    @voter_array.each do |v|
    if v.name == voter_name
        puts "I found it, please enter new name"
        new_name = gets.chomp
        puts <<-END
        Enter your updated political view.
        Please select the letter that reflects your political views?
        --(P)rogressive
        --(C)onservative
        --(L)ibertarian
        --(M)assachusetts Democrat
        --(I)ndependent
        END

        new_politics = gets.chomp.downcase
        case new_politics
        when "p"
          v.politics =  "Progressive"
        when "c"
          v.politics = "Conservative"
        when "l"
          v.politics = "Libertarian"
        when "m"
          v.politics = "Massachusetts Democrat"
        when "i"
          v.politics = "Independent"
        else
          puts "That is not a valid entry. Please try again."
          update_voter
        end
        v.name = new_name
        puts "Update Complete!"
        space
        print v.name.capitalize + "-"
        puts v.politics
    else
        puts "That voter does not exist."
        update_voter
    end
    end
  end

  def start
  while true
    # start = VoterSim.new
    intro
    display_choices
    main_menu_user_choice
    space
  end
  end
end
