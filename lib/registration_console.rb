class RegistrationConsole < CodebrakerConsole
  def run
    player_name = get_name
    difficulty = get_difficulty
    GameConsole.new(player_name, difficulty).run
  end

  private

  def get_name
    output_helper.player_name
    player_name = check_input(input_helper.player_name)
    output_helper.greeting(player_name)
    return player_name
  end

  def get_difficulty
    output_helper.choose_difficulty
    difficulty = check_input(input_helper.difficulty)
    output_helper.difficulty(difficulty)
    return difficulty
  end

  def check_input(input)
    input[:type] == :command ? send(:"#{input[:value]}_command") : input[:value]
  end
end
