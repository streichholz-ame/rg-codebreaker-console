RSpec.describe DataLoader do
  let(:dummy_class) { Class.new { extend DataLoader } }

  describe 'load_data' do
    let(:file_data) do
      "---\n"\
      " :name: Ame\n"\
      " :difficulty: :easy\n"\
      " :attempts_total: 15\n"\
      " :attempts_used: 1\n"\
      " :hints_total: 2\n"\
      " :hints_used: 0\n"\
      " :date: !ruby/object:DateTime 2021-02-23 14:28:52.481897200 +02:00\n"\
    end

    let(:file_records) do
      [
        {
          name: 'Ame',
          difficulty: :easy,
          attempts_total: 15,
          attempts_used: 1,
          hints_total: 2,
          hints_used: 0,
          date: DateTime.parse('2021-02-23 14:28:52.481897200 +02:00')
        }
      ]
    end

    it 'returns empty array if file does not exist' do
      allow(File).to receive(:exist?).and_return(false)
      expect(dummy_class.load_data).to eq([])
    end

    it 'returns empty array if file exist' do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return('')
      expect(dummy_class.load_data).to eq([])
    end

    it 'returns records if file exist' do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return(file_data)
      expect(dummy_class.load_data).to eq(file_records)
    end
  end

  describe 'save_data' do
    let(:file) { StringIO.new }
    let(:data) do
      {
        secret_code: %w[4 5 6 1],
        name: 'Ame',
        difficulty: :easy,
        attempts_max: 15,
        attempts: 1,
        hints_max: 2,
        hints: 0,
        date: DateTime.parse('2021-02-23 14:28:52.481897200 +02:00')
      }
    end

    it 'creates file and saves data into it' do
      allow(File).to receive(:open).with(Constants::DATA_FILE, 'a').and_yield(file)
      expect(file).to receive(:write).with(data.to_yaml)
      dummy_class.save_data(data)
    end
  end
end
