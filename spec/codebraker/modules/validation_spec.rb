RSpec.describe Validation do
  subject(:klass) { (Class.new { include Validation }).new }

  describe '#validate scenario command' do
    let(:valid_command) { Constants::SCENARIO_COMMANDS.sample }
    let(:invalid_command) { 'some command' }

    it 'returns nil if command is valid' do
      expect(klass.scenario_command_validate!(valid_command)).to eq(nil)
    end

    it 'returns error message if command is not valid' do
      expect { klass.scenario_command_validate!(invalid_command) }.to raise_error(Validation::WrongScenarioError)
    end
  end

  describe '#validate approve commands' do
    let(:valid_command) { Constants::APPROVAL_COMMANDS.sample }
    let(:invalid_command) { 'some command' }

    it 'returns nil if command is valid' do
      expect(klass.approve_command_validate!(valid_command)).to eq(nil)
    end

    it 'returns error message if command is not valid' do
      expect { klass.approve_command_validate!(invalid_command) }.to raise_error(Validation::WrongApproveCommandError)
    end
  end
end
