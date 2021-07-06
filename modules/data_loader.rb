module DataLoader
  def save_data(data)
    File.open(Constants::DATA_FILE, 'a') { |file| file.write(data.to_yaml) }
  end

  def load_data
    return [] unless File.exist?(Constants::DATA_FILE)

    YAML.load_stream(File.read(Constants::DATA_FILE)).map { |record| record } || []
  end
end
