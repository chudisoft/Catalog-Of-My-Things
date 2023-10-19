class LabelLoader
  def self.load_labels(main)
    return unless File.exist?('json_data/labels.json')

    labels_json = JSON.parse(File.read('json_data/labels.json'))
    labels_json.each do |label_data|
      name = label_data['name']
      color = label_data['color']
      label = Label.new(name, color)
      main.instance_variable_get(:@labels) << label
    end
  end
end
