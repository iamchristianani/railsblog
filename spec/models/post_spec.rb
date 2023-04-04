require 'rails_helper'

RSpec.describe Post, type: :model do
  author = User.create(name: 'Chris', photo: 'photo.png', bio: 'Software Engineer', posts_counter: 3)
  subject do
    Post.new(title: 'Post number 1', text: 'This is the first post', author_id: author.id, comments_counter: 2,
             likes_counter: 6)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should be maximum 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'should diplay most recent comments' do
    subject.comments_counter = 5
    expect(subject.recent_comments).to eq(subject.comments.last(5))
  end

  it 'should display likes_counter' do
    subject.likes_counter = 8
    expect(subject.likes_counter).to eq(8)
  end

  describe '#recent_comments' do
    before do
      7.times do |comment|
        Comment.create(author_id: author.id, text: "Comment #{comment}", post_id: subject.id)
      end
    end

    it 'post should have five recent comments' do
      expect(subject.recent_comments).to eq(subject.comments.order(created_at: :desc).limit(5))
    end

    it 'should return only 5 comments' do
      expect(subject.recent_comments.count).to eq(5)
    end
  end
end
