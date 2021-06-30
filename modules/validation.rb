module Validation
  include Errors

  def scenario_command_validate!(command)
    raise WrongScenarioError unless Constants::SCENARIO_COMMANDS.include?(command)
  end

  def approve_command_validate!(command)
    raise WrongApproveCommandError unless Constants::APPROVAL_COMMANDS.include?(command)
  end
end
