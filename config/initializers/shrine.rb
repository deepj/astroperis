# frozen_string_literal: true

require "shrine/storage/s3"

s3_options = {
  bucket: "astroperis",
  access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
  secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
  region: "eu-central-1"
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(**s3_options)
}

Shrine.plugin :activerecord # load Active Record integration
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # refresh metadata for cached files
Shrine.plugin :backgrounding
Shrine.plugin :presign_endpoint, presign_options: ->(request) {
  #  Uppy will send the "filename" and "type" query parameters 
  filename = request.params["filename"]
  type = request.params["type"]

  {
    content_disposition: ContentDisposition.inline(filename),
    content_type: type
    # content_length_range: 0..(10*1024*1024)
  }
}

Shrine::Attacher.promote_block do
  S3XmlImportJob.set(wait: 3.seconds).perform_async(record.id)
end
