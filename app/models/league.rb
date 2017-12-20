class League < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true
  validates :user_id, presence: true

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  before_validation :set_slug

  def to_param
    self.slug if slug
  end

  private

  def set_slug
    self.slug = name.parameterize if should_change_slug?
  end

  def should_change_slug?
    !name.blank?
  end
end
