require 'rails_helper'

# https://relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec
RSpec.describe 'requests', type: :request do
  describe 'GET /' do
    it 'renders the new form' do
      get '/'

      expect(response.body).to include('Upload Image')
      expect(response.body).to include('Submit')
    end
  end

  describe 'GET /requests/:id' do
    let!(:image) { image_for_upload('vegan_quote.png', 'png') }

    let!(:request) { Request.create(input_image: image) }

    it 'renders the show page' do
      get "/requests/#{request.id}"

      expect(response.body).to include('<img')
      expect(response.body).to include('<audio')
    end
  end

  describe 'POST /requests' do
    let!(:image) { image_for_upload('vegan_quote.png', 'png') }

    it 'creates a request' do
      post '/requests', params: { request: { input_image: image } }
      follow_redirect!

      # TODO: Fix flash message
      # expect(response.body).to include('Successfully processed')
      expect(response.body).to include('<img')
      expect(response.body).to include('<audio')
    end
  end
end