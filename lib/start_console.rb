class StartConsole < CodebrakerConsole
  def run
    output_helper.introduction
    game_menu
  end

  def game_menu
    output_helper.scenario(Constants::SCENARIO_COMMANDS.join(', '))
    scenario = input_helper.scenario_command
    public_send("#{scenario}_command".to_sym)
  end

  def start_command
    RegistrationConsole.new.run
    game_menu
  end

  def rules_command
    output_helper.rules
    game_menu
  end

  def rating_command
    output_helper.rating(RatingConsole.recorded_data)
    game_menu
  end
end
