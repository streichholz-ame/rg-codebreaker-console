RSpec.describe RatingConsole do
  describe '::add' do
    let(:new_record) do
      {
        name: 'player 3',
        difficulty: 'hard',
        attempts_total: 5,
        attempts_left: 3,
        hints_total: 1,
        hints_left: 0
      }
    end

    it 'adds game result to rating records' do
      expect(described_class).to receive(:save_data).with(new_record)
      described_class.add_data(new_record)
    end
  end

  describe '::rating_records' do
    let(:prepared_records) do
      [
        {
          name: 'player 7',
          difficulty: 'hard',
          attempts_total: 5,
          attempts_left: 2,
          hints_total: 1,
          hints_left: 0
        }
      ]
    end

    let(:sorted_records) do
      [
        {
          rating: 1,
          name: 'player 7',
          difficulty: 'hard',
          attempts_total: 5,
          attempts_left: 2,
          hints_total: 1,
          hints_left: 0
        }
      ]
    end

    it 'returns rating records with places' do
      allow(described_class).to receive(:load_data).and_return(prepared_records)
      expect(described_class.recorded_data(prepared_records)).to eq(sorted_records)
    end
  end
end
