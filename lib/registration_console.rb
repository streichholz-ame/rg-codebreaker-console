class RegistrationConsole < CodebrakerConsole
  def run
    output_helper.player_name
    player_name = check_input(input_helper.player_name)
    output_helper.greeting(player_name)

    output_helper.choose_difficulty
    difficulty = check_input(input_helper.difficulty)
    output_helper.difficulty(difficulty)

    GameConsole.new(player_name, difficulty).run
  end

  def check_input(input)
    input[:type] == :command ? public_send(:"#{input[:value]}_command") : input[:value]
  end
end
