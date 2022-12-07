# frozen_string_literal: true

module Users
  class UserFromOmniauthEvaluator < ApplicationService
    def initialize(user_info)
      @user_info = user_info
    end

    def call
      User.find_or_create_by(provider: user_info.provider, uid: user_info.uid) do |user|
        first_name, last_name = split_name(user_info.info.name.to_s)

        user.first_name = first_name.presence&.join
        user.last_name = last_name.presence
        user.email = user_info.info.email
        user.provider = user_info.provider
        user.uid = user_info.uid
      end
    end

    private

    attr_reader :user_info

    def split_name(name)
      name_parts = name.split(" ")
      return if name_parts.blank?

      [name_parts[0...], name_parts.last]
    end
  end
end
