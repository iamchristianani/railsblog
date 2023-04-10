require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before :each do
    @img = 'https://i0.wp.com/imgs.hipertextual.com/wp-content/uploads/2022/10/Andor_Luthen-Rael.png?fit=2554,1642&quality=60&strip=all&ssl=1',
    @author = User.create(name: 'Tom', photo: @img, bio: 'Teacher from South Africa'),
    @first_post = Post.create(author: @author, title: 'Tom Post #1', text: "This is Tom's first post")
    @second_post = Post.create(author: @author, title: 'Tom Post #2', text: "This is Tom's second post")

    @first_comment = Comment.create(post: @first_post, author: @author, text: 'First comment for Tom' )
    @second_comment = Comment.create(post: @second_post, author: @author, text: 'Second comment for Tom' )

    @first_like = Like.create(post: @first_post, author: @author)
    @second_like = Like.create(post: @second_post, author: @author)

    # visit user_posts_path(@author)
    # click_on @author.name 
  end

  it 'shows the author image' do
    expect(page.body).to include(@img)
  end

  it 'shows the author name' do
    expect(page).to have_content(@author.name)
  end

  it 'shows the number of posts by the author' do
    expect(page).to have_content('2 posts')
  end

  it 'shows the post title' do
    expect(page).to have_content(@first_post.title)
  end

  it 'shows the post text' do
    expect(page).to have_content(@first_post.text)
  end

  it 'shows the first comments on the post' do
    expect(page).to have_content(@first_comment.text)
  end

  it 'shows the number of comments on the post' do
    expect(page).to have_content('1 comment')
  end

  it 'shows the number of likes on the post' do
    expect(page).to have_content('1 like')
  end

  it "when clicking on a post title, it redirects to the post's show page" do
    click_on @first_post.title
    expect(page).to have_content(@first_post.title)
  end
end
