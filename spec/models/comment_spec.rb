require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    author = User.create(name: 'Chris', photo: 'photo.png', bio: 'Software Engineer', posts_counter: 3)
    post = Post.create(author_id: author.id, title: 'Post', text: 'Hello world!', likes_counter: 4, comments_counter: 2)
    subject { Comment.new(author_id: author.id, post_id: post.id, text: 'Comment') }

    before { subject.save }

    it 'author id should be a number' do
      subject.author_id = 'a'
      expect(subject).to_not be_valid
    end

    it 'post id should be a number' do
      subject.post_id = 'b'
      expect(subject).to_not be_valid
    end

    it 'increments comments_counter' do
      expect(post.comments_counter).to_not eq(6)
      expect(post.comments_counter).to eq(2)
    end
  end
end
