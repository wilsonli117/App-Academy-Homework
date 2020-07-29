class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end


  def play
    until self.game_over
      self.take_turn
    end
    self.game_over_message
    self.reset_game
  end


  def take_turn
    self.show_sequence
    sleep 1
    system("clear")
    self.require_sequence
    if !self.game_over
      self.round_success_message
      self.sequence_length += 1
    end
  end

  def show_sequence
    self.add_random_color
    print self.seq
  end

  def require_sequence

    puts "Enter the sequence separated by commas"
    response = gets.chomp
    if response.split(",") == self.seq
      return true
    else
      self.game_over = true
    end

  end

  def add_random_color
    self.seq << COLORS.sample
  end

  def round_success_message
    puts "Success!"
  end

  def game_over_message
    puts "Game Over :("
    puts "Your score was #{self.sequence_length}"
  end

  def reset_game
    self.sequence_length = 1
    self.game_over = false
    self.seq = []
  end
end
