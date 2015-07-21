

class Candidate
  attr_accessor :name, :party, :vote_for

  def initialize(name, party)
    @name = name
    @party = party
    @vote_for = party
  end
end
