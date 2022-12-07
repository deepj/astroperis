# frozen_string_literal: true

class AstronautXmlParser
  def self.call(io)
    new(io).parse_by_chunks
  end

  def initialize(io)
    @io = io
    @parser = Nokogiri::XML::Reader
  end

  def parse_by_chunks
    io.rewind

    Enumerator.new do |yielder|
      parser.from_io(io).each do |node|
        if node.name == "astronaut" && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
          yielder << build_astronaut(Nokogiri::XML(node.outer_xml).root)
        end
      end
    end
  end

  private

  attr_reader :io, :parser

  def build_astronaut(node)
    {
      first_name: node.xpath("first_name").text,
      last_name: node.xpath("last_name").text,
      position: node.xpath("position").text,
      age: node.xpath("age").text,
      country_code: node.xpath("country_code").text
    }
  end
end
