class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter

  def initialize(attributes = {})
    super
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
