require 'rails_helper'

RSpec.describe 'navbar', type: :request do
  it 'renders link to homepage' do
    get '/'

    expect(response.body).to include('<a href="/" class="item">')
  end
end