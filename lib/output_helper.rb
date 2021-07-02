class OutputHelper
  def introduction
    puts I18n.t(:introduction_message)
  end

  def scenario(commands)
    puts I18n.t(:select_scenario_message, commands: commands)
  end

  def wrong_scenario
    puts I18n.t(:wrong_scenario_message)
  end

  def rules
    puts I18n.t(:rules_message)
  end

  def player_name
    puts I18n.t(:player_name_message)
  end

  def wrong_player_name
    puts I18n.t(:wrong_player_name_message)
  end

  def greeting(player_name)
    puts I18n.t(:greeting_message, player_name: player_name)
  end

  def choose_difficulty
    puts I18n.t(:choose_difficulty_message)
  end

  def wrong_difficulty
    puts I18n.t(:wrong_difficulty_message)
  end

  def difficulty(difficulty)
    puts I18n.t(:"difficulties.#{difficulty}")
  end

  def guess_input
    puts I18n.t(:guess_input_message)
  end

  def wrong_guess_input
    puts I18n.t(:wrong_guess_input_message)
  end

  def guess_result(result)
    puts result
  end

  def hint(hint)
    puts I18n.t(:hint_message, hint: hint)
  end

  def no_hint
    puts I18n.t(:no_hint_message)
  end

  def wrong_command
    puts I18n.t(:wrong_command_message)
  end

  def win
    puts I18n.t(:win_message)
  end

  def lost
    puts I18n.t(:lose_message)
  end

  def answer(secret_code)
    puts I18n.t(:answer_message, secret_code: secret_code)
  end

  def save_result(command)
    puts I18n.t(:save_result_message, command: command)
  end

  def rating(rating_records)
    rating_message
    rating_header
    rating_records.each { |record| rating_records(record) }
  end

  def exit_game
    puts I18n.t(:exit_message)
  end

  private

  def rating_message
    puts I18n.t(:rating_message)
  end

  def rating_header
    puts I18n.t(:rating_data_header)
  end

  def rating_records(data)
    puts I18n.t(:rating_data_input, **data)
  end
end
