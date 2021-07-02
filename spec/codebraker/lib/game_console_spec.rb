RSpec.describe GameConsole do
  let(:game_console) { described_class.new(player_name, difficulty) }

  let(:player_name) { 'a' * Codebraker::Validation::MIN_NAME_LENGTH }
  let(:difficulty) { Codebraker::Constants::DIFFICULTIES.keys.sample.to_s }
  let(:secret_code) { '1234' }

  describe '#run' do
    let(:guess) { '1111' }
    let(:hint_command) { 'hint' }

    it 'command input' do
      allow(game_console.input_helper).to receive(:guess).and_return({ type: :command, value: hint_command })
      expect(game_console).to receive(:hint_command)
      game_console.run
    end

    it 'guess input' do
      allow(game_console.input_helper).to receive(:guess).and_return({ type: :input, value: guess })
      expect(game_console).to receive(:show_result)
      game_console.run
    end
  end

  describe '#hint_command' do
    let(:hint) { rand(1..6) }

    it 'give hint if hint validated' do
      allow(game_console.game).to receive(:give_hint).and_return(hint)
      allow(game_console.output_helper).to receive(:hint).with(hint)
      expect(game_console).to receive(:run)
      game_console.hint_command
    end

    it 'give no hint message if hint empty' do
      game_console.game.instance_variable_set(:@hints, [])
      expect(game_console.output_helper).to receive(:no_hint)
      game_console.hint_command
    end
  end

  describe '#show_result' do
    let(:win_result) { { answer: '++++', status: :win, code: secret_code } }
    let(:lose_result) { { answer: '-', status: :lost, code: secret_code } }
    let(:result) { { answer: '-', status: :next } }
    let(:rating_instance) { instance_double(RatingConsole) }

    context 'when user win' do
      it 'save result if answer yes' do
        allow(game_console.input_helper).to receive(:approve_command).and_return('yes')
        expect(RatingConsole).to receive(:add_data)
        game_console.show_result(win_result)
      end

      it 'not save result' do
        allow(game_console.input_helper).to receive(:approve_command).and_return('no')
        expect(RatingConsole).not_to receive(:add_data)
        game_console.show_result(win_result)
      end
    end

    it 'lost' do
      allow(game_console.output_helper).to receive(:guess_result).with(lose_result[:answer])
      allow(game_console.output_helper).to receive(:lose_message)
      allow(game_console.output_helper).to receive(:result).with(lose_result[:code])
      expect(game_console).not_to receive(:run)
      game_console.show_result(lose_result)
    end

    it 'continue game' do
      allow(game_console.output_helper).to receive(:guess_result).with(result[:answer])
      expect(game_console).to receive(:run)
      game_console.show_result(result)
    end
  end
end
