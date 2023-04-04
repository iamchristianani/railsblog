require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Chris',
      photo: 'http://picsum.photos/150/120',
      bio: 'Software Engineer',
      posts_counter: 5
    )
  end
  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with invalid name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with posts_counter not greater or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  describe '#recent_posts' do
    before do
      5.times do |post|
        Post.create(author_id: subject.id, title: "Post  #{post}", text: "Text #{post}", comments_counter: 2,
                    likes_counter: 6)
      end
    end

    it 'should return recent posts' do
      expect(subject.recent_posts).to eq(subject.posts.order(created_at: :desc).limit(3))
    end

    it 'should return only 3 posts' do
      expect(subject.recent_posts.count).to eq(3)
    end
  end
end
