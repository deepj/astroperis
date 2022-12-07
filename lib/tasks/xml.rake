# frozen_string_literal: true

namespace :xml do
  task :fake_data, [:file_size, :file_name] => :environment do |_, args|
    RandomAstronaut = Struct.new(:first_name, :last_name, :position, :age, :country_code, keyword_init: true)

    def random_age = rand(20..60)

    def random_country_code = %w[US GB CA AU NZ].sample

    def random_position = %w[commander pilot copilot engineer scientist].sample

    def generate_astronaut = RandomAstronaut.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, position: random_position, age: random_age, country_code: random_country_code)

    # Set default and minimum/maximum file size
    file_size = args.fetch(:file_size, 100).to_i # default file size is 50 MB
    if file_size < 1
      file_size = 1 # minimum file size is 1 MB
    elsif file_size > 1024
      file_size = 1024 # maximum file size is 1024 MB (1 GB)
    end

    # Set default file name
    file_name = args.fetch(:file_name, "fake_data.xml")

    # Create a progress bar to track file generation progress
    progressbar = ProgressBar.create(title: "Generating", total: file_size.megabytes, format: "%a <%B> %p%% %t")
    records_count = 0

    # Open the XML file for writing
    xml = File.new(file_name, "w")

    # Write XML declaration and root element
    xml.puts(<<~XML.strip_heredoc)
      <?xml version="1.0" encoding="UTF-8"?>
      <astronaut_list>
    XML

    # Generate fake astronaut data and write it to the XML file
    # until the specified file size is reached or the maximum file size is reached
    loop do
      astronaut = generate_astronaut

      xml.puts(<<~XML.indent(2))
        <astronaut>
          <first_name>#{astronaut.first_name}</first_name>
          <last_name>#{astronaut.last_name}</last_name>
          <position>#{astronaut.position}</position>
          <age>#{astronaut.age}</age>
          <country_code>#{astronaut.country_code}</country_code>
        </astronaut>
      XML

      records_count += 1
      if xml.pos >= progressbar.total
        progressbar.progress = progressbar.total
        break
      else
        progressbar.progress = xml.pos
      end
    end

    # Write closing tag for root element
    xml.puts("</astronaut_list>")

    # Close the XML file
    xml.close

    # Output completion message
    puts
    puts "Done. Records generated: #{records_count}"
  end

  task :import_fake_data, [:file_name] => :environment do |_, args|
    file_name = args.fetch(:file_name, "fake_data.xml")

    data_file = File.open(file_name)

    progressbar = ProgressBar.create(title: "Importing", total: data_file.size, format: "%a <%B> %p%% %t")
    records_count = 0

    build_astronaut = ->(node) do
      {first_name: node.xpath("first_name").text, last_name: node.xpath("last_name").text, position: node.xpath("position").text, age: node.xpath("age").text, country_code: node.xpath("country_code").text}
    end

    extracting_astronauts = Enumerator.new do |yielder|
      Nokogiri::XML::Reader.from_io(data_file).each do |node|
        if node.name == "astronaut" && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
          yielder << build_astronaut(node)
        end
      end
    end.lazy

    extracting_astronauts
      .map(&extract_astronaut)
      .each_slice(5_000) do |astronauts|
        Astronaut.insert_all(astronauts)
        progressbar.progress = data_file.pos
        records_count += astronauts.size
      end

    data_file.close

    puts
    puts "Done. Records generated: #{records_count}"
  end
end
