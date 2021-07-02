class GameConsole < CodebrakerConsole
  attr_accessor :game

  def initialize(player_name, difficulty)
    @game = Codebraker::Game.new(player_name, difficulty.to_sym)
    @start_console = StartConsole.new
    super()
  end

  def run
    output_helper.guess_input
    input = input_helper.guess
    case input[:type]
    when :command then public_send("#{input[:value]}_command")
    when :input
      guess = game.check_guess(input[:value])
      show_result(guess)
    end
  end

  def hint_command
    hint = game.give_hint
  rescue Codebraker::Errors::HintError
    output_helper.no_hint
  else
    output_helper.hint(hint)
    run
  end

  def show_result(guess)
    result = guess[:answer]
    output_helper.guess_result(result)
    case guess[:status]
    when :win
      win(guess[:code])
      save_result
    when :lost then lost(guess[:code])
    else run
    end
  end

  private

  def win(code)
    output_helper.win
    output_helper.answer(code)
  end

  def lost(code)
    output_helper.lost
    output_helper.answer(code)
  end

  def save_result
    output_helper.save_result(Constants::APPROVAL_COMMANDS.join('/'))
    command = input_helper.approve_command
    RatingConsole.add_data(game.to_h) if command == Constants::AGREE_COMMAND
  end
end
