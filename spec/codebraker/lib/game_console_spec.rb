RSpec.describe GameConsole do
  let(:game_console) { described_class.new(player_name, difficulty) }

  let(:player_name) { 'a' * Codebraker::Validation::MIN_NAME_LENGTH }
  let(:difficulty) { Codebraker::Constants::DIFFICULTIES.keys.sample.to_s }
  let(:secret_code) { game_console.game.secret_code.join('') }

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
    let(:hint_command) { 'hint' }
    let(:hint) { rand(1..6) }

    before do
      allow(game_console.input_helper).to receive(:guess).and_return({ type: :command, value: hint_command })
    end

    it 'give hint if hint validated' do
      allow(game_console.game).to receive(:give_hint).and_return(hint)
      allow(game_console.output_helper).to receive(:hint).with(hint)
      expect(game_console).to receive(:run)
      game_console.run
    end

    it 'give no hint message if hint empty' do
      game_console.game.instance_variable_set(:@hints, [])
      expect(game_console.output_helper).to receive(:no_hint)
      game_console.run
    end
  end

  describe '#show_result' do
    let(:win_result) { { answer: '++++', status: :win, code: secret_code } }
    let(:lose_result) { { answer: '-', status: :lost, code: secret_code } }
    let(:result) { { answer: '-', status: :next } }

    context 'when user win' do
      before do
        allow(game_console.input_helper).to receive(:guess).with(secret_code)
      end

      after { game_console.show_result(win_result) }
      it 'save result if answer yes' do
        allow(game_console.input_helper).to receive(:approve_command).and_return('yes')
        expect(RatingConsole).to receive(:add_data)
      end

      it 'not save result' do
        allow(game_console.input_helper).to receive(:approve_command).and_return('no')
        expect(RatingConsole).not_to receive(:add_data)
      end
    end

    context 'when user lost' do
      it 'lost' do
        allow(game_console.output_helper).to receive(:guess_result).with(lose_result[:answer])
        allow(game_console.output_helper).to receive(:lose_message)
        allow(game_console.output_helper).to receive(:result).with(lose_result[:code])
        expect(game_console).not_to receive(:run)
      end
    end

    context 'when game is not over' do
      it 'continue game' do
        expect(game_console).to receive(:run)
        game_console.show_result(result)
      end
    end
  end
end
