# frozen_string_literal: true

class User < ApplicationRecord
  devise :rememberable, :omniauthable, omniauth_providers: %i[github gitlab]

  has_many :imports, dependent: :destroy
end
