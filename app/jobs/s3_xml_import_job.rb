# frozen_string_literal: true

class S3XmlImportJob
  include Sidekiq::Job

  BATCH_SIZE = 5_000

  queue_as :default

  def perform(import_id)
    import = Import.find(import_id)
    import.process!

    begin
      import_file_from_s3 = Down.open(import.file_url)
      preparing_astronauts = AstronautXmlParser.call(import_file_from_s3)

      Astronaut.transaction do
        preparing_astronauts.each_slice(BATCH_SIZE) do |astronauts|
          Astronaut.insert_all!(astronauts, returning: false)
        end
      end
    rescue StandardError => exception
      import.fail!
      Rails.logger.error("#{self.class.name}: Import failed: #{exception.message}")
    end

    import.complete!
  rescue ActiveRecord::RecordInvalid => exception
    Rails.logger.error("#{self.class.name}: Import not found: #{exception.message}")
  end
end
