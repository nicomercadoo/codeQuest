# frozen_string_literal: true

class Snippet < ActiveRecord::Base
  validates :code, presence: true
  validates :account_id, presence: true

  belongs_to :account
end
