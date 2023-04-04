require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validations' do
    author = User.create(name: 'Chris', photo: 'photo.png', bio: 'Software Engineer', posts_counter: 3)
    post = Post.create(author_id: author.id, title: 'Post', text: 'Hello world!', likes_counter: 4, comments_counter: 2)
    subject { Like.new(author_id: author.id, post_id: post.id) }

    before { subject.save }

    it 'author id should be an integer' do
      subject.author_id = 'a'
      expect(subject).to_not be_valid
    end

    it 'post id should be an integer' do
      subject.post_id = 'p'
      expect(subject).to_not be_valid
    end

    it 'increments likes_counter' do
      expect(post.likes_counter).to_not eq(6)
      expect(post.likes_counter).to eq(4)
    end
  end
end
