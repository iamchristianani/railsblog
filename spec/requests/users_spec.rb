require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /index' do
    it 'returns a successful http request and renders the index template' do
      get root_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'includes the correct text in the index body' do
      get root_path
      expect(response.body).to include('Page Showing Lists of Users')
    end
  end

  describe 'GET /show' do
    it 'returns a successful http request and renders the index template' do
      user = User.create(name: 'Chris', id: '001')
      get user_path(user)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end

    it 'includes the correct text in the response body' do
      user = User.create(name: 'Chris', id: '001')
      get user_path(user)
      expect(response.body).to include('Page Showing a Particular User')
    end
  end
end
