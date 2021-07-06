module Errors
  class WrongScenarioError < StandardError
    WRONG_SCENARIO_MESSAGE = I18n.t(:wrong_scenario_message)
    def initialize(msg = WRONG_SCENARIO_MESSAGE)
      super
    end
  end

  class WrongApproveCommandError < StandardError
    WRONG_APPROVE_COMMAND_MESSAGE = I18n.t(:wrong_command_error)
    def initialize(msg = WRONG_APPROVE_COMMAND_MESSAGE)
      super
    end
  end
end
