require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET /index' do
    it 'returns a successful http request and renders the index template' do
      get user_posts_path(user_id: 1)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'includes the correct text in the index body' do
      get user_posts_path(user_id: 1)
      expect(response.body).to include('Page Showing Lists of Posts')
    end
  end

  describe 'GET /show' do
    it 'returns a successful http request and renders the index template' do
      post = Post.create(title: 'Test Title', id: 1)
      get user_post_path(user_id: 1, id: post.id)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end

    it 'includes the correct text in the response body' do
      post = Post.create(title: 'Test Title', id: 1)
      get user_post_path(user_id: 1, id: post.id)
      expect(response.body).to include('Page Showing a Particular Post')
    end
  end
end
