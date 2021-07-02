require 'pry'

class InputHelper
  include Validation
  include Codebraker::Validation

  attr_reader :output_helper

  def initialize
    @output_helper = OutputHelper.new
  end

  def player_name
    player_name = gets.chomp
    check_input(player_name, :player_name, Constants::EXIT_COMMAND)
  rescue Codebraker::Errors::WrongNameError
    output_helper.wrong_player_name
    output_helper.player_name
    retry
  end

  def scenario_command
    scenario_command = gets.chomp
    scenario_command_validate!(scenario_command)
    scenario_command
  rescue WrongScenarioError
    output_helper.wrong_scenario
    output_helper.scenario(Constants::SCENARIO_COMMANDS.join(', '))
    retry
  end

  def difficulty
    difficulty = gets.chomp
    check_input(difficulty, :difficulty, Constants::EXIT_COMMAND)
  rescue Codebraker::Errors::WrongDifficultyError
    output_helper.wrong_difficulty
    output_helper.choose_difficulty
    retry
  end

  def guess
    guess = gets.chomp
    check_input(guess, :guess, Constants::GAME_COMMANDS)
  rescue Codebraker::Errors::InvalidGuessError
    output_helper.wrong_guess_input
    output_helper.guess_input
    retry
  end

  def approve_command
    approve_command = gets.chomp
    approve_command_validate!(approve_command)
    approve_command
  rescue WrongApproveCommandError
    output_helper.wrong_command
    output_helper.save_result(Constants::APPROVAL_COMMANDS.join('/'))
    retry
  end

  private

  def check_input(input, input_type, command)
    case input
    when *command
      { type: :command, value: input }
    else
      public_send("#{input_type}_validate!", input)
      { type: :input, value: input }
    end
  end
end
