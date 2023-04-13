class Blog < ApplicationRecord
  validates :title, presence: true, length: {maximum: 60}
  validates :body, presence: true, length: {maximum: 255}
  validates :published_at, comparison: {greater_than_or_equal_to: Time.current, message: "can't be in past"}, allow_nil: true
  
  scope :draft, -> { where(published_at: nil)}
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current)}

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

end
