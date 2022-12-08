# frozen_string_literal: true

class Import < ApplicationRecord
  include S3Uploader::Attachment.new(:file)

  enum :state, %i[pending processing completed failed], default: :pending

  belongs_to :user

  scope :last_5_imports, -> { order(created_at: :desc).limit(5) }

  validates :file, presence: true
  validates :file_name, presence: true

  def process! = update(state: :processing, started_at: Time.current)

  def complete! = update(state: :completed, finished_at: Time.current)

  def fail! = update(state: :failed, failed_at: Time.current)
end
