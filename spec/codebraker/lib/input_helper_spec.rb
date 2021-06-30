RSpec.describe InputHelper do
  let(:input_helper) { described_class.new }

  describe '#player_name' do
    let(:valid_name) { 'a' * Codebraker::Validation::MIN_NAME_LENGTH }
    let(:invalid_name) { 'a' * Codebraker::Validation::MIN_NAME_LENGTH.pred }

    it 'return if name valid' do
      allow(input_helper).to receive(:gets).and_return(valid_name)
      expect(input_helper.player_name).to eq({ type: :input, value: valid_name })
    end

    it 'retry if name invalid' do
      allow(input_helper).to receive(:gets).and_return(invalid_name, valid_name)
      allow(input_helper).to receive(:retry)
      expect(input_helper.player_name).to eq({ type: :input, value: valid_name })
      input_helper.player_name
    end

    it 'return exit if input exit' do
      allow(input_helper).to receive(:gets).and_return('exit')
      expect(input_helper.player_name).to eq({ type: :command, value: 'exit' })
    end
  end

  describe '#scenario_commands' do
    let(:valid_command) { 'start' }
    let(:invalid_command) { 'starttt' }

    it 'return command if command valid' do
      allow(input_helper).to receive(:gets).and_return(valid_command)
      expect(input_helper.scenario_command).to eq(valid_command)
    end

    it 'retry if command invalid' do
      allow(input_helper).to receive(:gets).and_return(invalid_command, valid_command)
      allow(input_helper).to receive(:retry)
      expect(input_helper.scenario_command).to eq(valid_command)
      input_helper.scenario_command
    end
  end

  describe '#difficulty' do
    let(:valid_difficulty) { Codebraker::Constants::DIFFICULTIES.keys.sample.to_s }
    let(:invalid_difficulty) { 'difficulty' }

    it 'pass if difficulty valid' do
      allow(input_helper).to receive(:gets).and_return(valid_difficulty)
      expect(input_helper.difficulty).to eq({ type: :input, value: valid_difficulty })
    end

    it 'retry if difficulty invalid' do
      allow(input_helper).to receive(:gets).and_return(invalid_difficulty, valid_difficulty)
      allow(input_helper).to receive(:retry)
      expect(input_helper.difficulty).to eq({ type: :input, value: valid_difficulty })
      input_helper.difficulty
    end
  end

  describe '#guess' do
    let(:valid_guess) { '3562' }
    let(:invalid_guess) { 'h781' }
    let(:valid_command) { 'hint' }

    it 'returns hint if user puts valid command' do
      allow(input_helper).to receive(:gets).and_return(valid_command)
      expect(input_helper.guess).to eq({ type: :command, value: valid_command })
    end

    it 'returns difficulty if difficulty is valid' do
      allow(input_helper).to receive(:gets).and_return(valid_guess)
      expect(input_helper.guess).to eq({ type: :input, value: valid_guess })
      input_helper.guess
    end

    it 'returns exit if player inputs exit' do
      allow(input_helper).to receive(:gets).and_return('exit')
      expect(input_helper.guess).to eq({ type: :command, value: 'exit' })
    end

    it 'raise error if guess is not valid' do
      allow(input_helper).to receive(:gets).and_return(invalid_guess, valid_guess)
      allow(input_helper).to receive(:retry)
      expect(input_helper.guess).to eq({ type: :input, value: valid_guess })
      input_helper.guess
    end
  end

  describe '#save_result' do
    let(:valid_answer) { Constants::AGREE_COMMAND }
    let(:invalid_answer) { 'a' * Codebraker::Validation::MIN_NAME_LENGTH }

    it 'receive yes' do
      allow(input_helper).to receive(:gets).and_return(valid_answer)
      expect(input_helper.approve_command).to eq(valid_answer)
    end

    it 'receive wrong command' do
      allow(input_helper).to receive(:gets).and_return(invalid_answer, valid_answer)
      allow(input_helper).to receive(:retry)
      expect(input_helper.approve_command).to eq(valid_answer)
      input_helper.approve_command
    end
  end
end
