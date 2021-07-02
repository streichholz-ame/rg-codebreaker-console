RSpec.describe RegistrationConsole do
  let(:registration_console) { described_class.new }

  describe '#run' do
    let(:game) { instance_double(GameConsole) }
    let(:player_name) { 'a' * Codebraker::Validation::MIN_NAME_LENGTH }
    let(:difficulty) { Codebraker::Constants::DIFFICULTIES.keys.sample.to_s }
    let(:player_input) { { type: :input, value: player_name } }
    let(:difficulty_input) { { type: :input, value: difficulty } }
    let(:exit_input) { { type: :command, value: 'exit' } }

    it 'run game when input correct' do
      allow(registration_console.input_helper).to receive(:player_name).and_return(player_input)
      allow(registration_console.input_helper).to receive(:difficulty).and_return(difficulty_input)
      allow(GameConsole).to receive(:new).with(player_name, difficulty).and_return(game)
      expect(game).to receive(:run)
      registration_console.run
    end

    it 'call exit when input exit' do
      allow(registration_console.input_helper).to receive(:player_name).and_return(exit_input)
      allow(registration_console).to receive(:public_send).with(:exit_command).and_throw(:exit)
      expect { registration_console.run }.to throw_symbol :exit
    end

    it 'calls exit when user put exit in difficulty' do
      allow(registration_console.output_helper).to receive(:player_name)
      allow(registration_console.input_helper).to receive(:player_name).and_return(player_input)
      allow(registration_console.output_helper).to receive(:difficulty)
      allow(registration_console.input_helper).to receive(:difficulty).and_return(exit_input)
      allow(registration_console).to receive(:public_send).with(:exit_command).and_throw(:exit)
      expect { registration_console.run }.to throw_symbol :exit
    end
  end
end
