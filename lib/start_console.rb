class StartConsole < CodebrakerConsole
  def run
    output_helper.introduction
    game_menu
  end

  def game_menu
    output_helper.scenario(Constants::SCENARIO_COMMANDS.join(', '))
    scenario = input_helper.scenario_command
    send("#{scenario}_command")
  end

  private

  def start_command
    RegistrationConsole.new.run
    game_menu
  end

  def rules_command
    output_helper.rules
    game_menu
  end

  def rating_command
    output_helper.rating(RatingConsole.records)
    game_menu
  end
end
