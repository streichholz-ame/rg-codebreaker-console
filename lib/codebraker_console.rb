class CodebrakerConsole
  attr_accessor :output_helper, :input_helper

  def initialize
    @output_helper = OutputHelper.new
    @input_helper = InputHelper.new
  end

  def exit_command
    output_helper.exit_game
    exit
  end
end
