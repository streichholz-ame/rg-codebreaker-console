class RegistrationConsole < CodebrakerConsole
  def run
    name = player_name
    difficulty = player_difficulty
    GameConsole.new(name, difficulty).run
  end

  private

  def player_name
    output_helper.player_name
    player_name = check_input(input_helper.player_name)
    output_helper.greeting(player_name)
    player_name
  end

  def player_difficulty
    output_helper.choose_difficulty
    difficulty = check_input(input_helper.difficulty)
    output_helper.difficulty(difficulty)
    difficulty
  end

  def check_input(input)
    input[:type] == :command ? send(:"#{input[:value]}_command") : input[:value]
  end
end
