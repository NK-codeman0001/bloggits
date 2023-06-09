class Blog < ApplicationRecord
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # def should_generate_new_friendly_id?
  #   new_record?
  # end

  has_rich_text :content
  has_many :comments

  validates :title, presence: true, length: {maximum: 120}
  validates :content, presence: true
  # validates :published_at, comparison: {greater_than_or_equal_to: Time.current, message: "can't be in past"}, allow_nil: true
  
  scope :draft, -> { where(published_at: nil)}
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current)}
  scope :archived, -> { where(archived: true)}

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def self.search(search)
    if search
      where('LOWER(title) LIKE ?', "%#{search.downcase}%")
    else
      all
    end
  end

end
