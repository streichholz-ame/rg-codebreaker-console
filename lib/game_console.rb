require 'pry'

class GameConsole < CodebrakerConsole
  attr_accessor :game

  def initialize(player_name, difficulty)
    @game = Codebraker::Game.new(player_name, difficulty.to_sym)
    super()
  end

  def run
    output_helper.guess_input
    input = input_helper.guess
    binding.pry
    case input[:type]
    when :command then send("#{input[:value]}_command")
    when :input
      guess = game.check_guess(input[:value])
      show_result(guess)
    end
  end
  
  private
  
  def hint_command
    hint = game.give_hint
  rescue Codebraker::Errors::HintError
    output_helper.no_hint
  else
    output_helper.hint(hint)
    run
  end

  def show_result(guess)
    binding.pry
    result = guess[:answer]
    output_helper.guess_result(result)
    check_status(guess)
  end

  def check_status(guess)
    binding.pry
    case guess[:status]
    when :win
      win(guess)
      save_result
    when :lost then lost(guess)
    else run
    end
  end

  def win(guess)
    output_helper.win
    give_answer(guess[:code])
  end

  def lost(guess)
    output_helper.lost
    give_answer(guess[:code])
  end

  def give_answer(code)
    output_helper.answer(code)
  end

  def save_result
    output_helper.save_result(Constants::APPROVAL_COMMANDS.join('/'))
    command = input_helper.approve_command
    RatingConsole.add_data(game.to_h) if command == Constants::AGREE_COMMAND
  end
end
