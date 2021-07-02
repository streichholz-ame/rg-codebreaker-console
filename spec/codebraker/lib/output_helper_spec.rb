RSpec.describe OutputHelper do
  subject(:output_helper) { described_class.new }

  describe '#introduction' do
    it 'show introduction message' do
      expect { output_helper.introduction }.to output { I18n.t(:introduction_message) }.to_stdout
    end
  end

  describe '#scenario' do
    it 'show scenario message' do
      expect { output_helper.scenario('%{commands}') }.to output { I18n.t(:select_scenario_message) }.to_stdout
    end
  end

  describe '#wrong_scenario' do
    it 'show wrong scenario message' do
      expect { output_helper.wrong_scenario }.to output { I18n.t(:wrong_scenario_message) }.to_stdout
    end
  end

  describe '#rules' do
    it 'show rules message' do
      expect { output_helper.rules }.to output { I18n.t(:rules_message) }.to_stdout
    end
  end

  describe '#player_name' do
    it 'show player name message' do
      expect { output_helper.player_name }.to output { I18n.t(:player_name_message) }.to_stdout
    end
  end

  describe '#wrong_player_name' do
    it 'show wrong player name message' do
      expect { output_helper.wrong_player_name }.to output { I18n.t(:wrong_player_name_message) }.to_stdout
    end
  end

  describe '#greeting' do
    let(:player_name) { 'player' }

    it 'show greeting message' do
      expect { output_helper.greeting(player_name) }.to output { I18n.t(:greeting_message) }.to_stdout
    end
  end

  describe '#choose_difficulty' do
    it 'show choose difficulty message' do
      expect { output_helper.choose_difficulty }.to output { I18n.t(:choose_difficulty_message) }.to_stdout
    end
  end

  describe '#wrong_difficulty' do
    it 'show wrong difficulty message' do
      expect { output_helper.wrong_difficulty }.to output { I18n.t(:wrong_difficulty_message) }.to_stdout
    end
  end

  describe '#wrong_command' do
    it 'show wrong command message' do
      expect { output_helper.wrong_command }.to output { I18n.t(:wrong_command_message) }.to_stdout
    end
  end

  describe '#wrong_guess_input' do
    it 'show message' do
      expect { output_helper.wrong_guess_input }.to output { I18n.t(:guess_input_message) }.to_stdout
    end
  end

  describe '#guess_input' do
    it 'show message' do
      expect { output_helper.guess_input }.to output { I18n.t(:wrong_guess_input_message) }.to_stdout
    end
  end

  describe '#hint' do
    let(:hint) { rand(1..6) }

    it 'show hint' do
      expect { output_helper.hint(hint) }.to output { I18n.t(:hint_message) }.to_stdout
    end
  end

  describe '#no_hint' do
    it 'show no hint message' do
      expect { output_helper.no_hint }.to output { I18n.t(:no_hint_message) }.to_stdout
    end
  end

  describe '#win' do
    it 'show win message' do
      expect { output_helper.win }.to output { I18n.t(:win_message) }.to_stdout
    end
  end

  describe '#lost' do
    it 'show message' do
      expect { output_helper.lost }.to output { I18n.t(:lose_message) }.to_stdout
    end
  end

  describe '#answer' do
    let(:secret_code) { '1234' }

    it 'show message' do
      expect { output_helper.answer(secret_code) }.to output { I18n.t(:answer) }.to_stdout
    end
  end

  describe '#guess_result' do
    let(:result) { "+-\n" }

    it 'shows check result' do
      expect { output_helper.guess_result(result.chomp) }.to output(result).to_stdout
    end
  end

  describe '#rating' do
    let(:rating_message) { "Rating message\n" }
    let(:rating_header) { "Rating header\n" }
    let(:rating_record) { "Rating record\n" }
    let(:rating) { rating_message + rating_header + rating_record }
    let(:rating_records) { [{ key: 'value' }] }

    it 'shows message from config :rating_message, :rating_data_header, :rating_data_input' do
      allow(I18n).to receive(:t).with(:rating_message).and_return(rating_message.chomp)
      allow(I18n).to receive(:t).with(:rating_data_header).and_return(rating_header.chomp)
      allow(I18n).to receive(:t).with(:rating_data_input, **rating_records[0]).and_return(rating_record.chomp)
      expect { output_helper.rating(rating_records) }.to output(rating).to_stdout
    end
  end
end
