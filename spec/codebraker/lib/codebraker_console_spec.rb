RSpec.describe CodebrakerConsole do
  describe '#exit' do
    let(:console) { described_class.new }

    it 'exit app' do
      allow(console.output_helper).to receive(:gets).and_return('exit')
      expect(console).to receive(:exit)
      console.exit_command
    end
  end
end
