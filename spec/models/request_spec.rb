require 'rails_helper'

RSpec.describe Request, type: :model do
  describe 'validations' do
    let!(:request) { Request.new(input_image: image) }

    context 'when a png is attached' do
      let!(:image) { image_for_upload('vegan_quote.png', 'png') }

      it 'returns a valid request' do
        expect(request.valid?).to be_truthy
      end
    end

    context 'when no image is attached' do
      let!(:image) { nil }

      it 'returns an invalid request' do
        expect(request.valid?).to be_falsey
      end
    end

    context 'when a non-png is attached' do
      let!(:image) { image_for_upload('example.jpeg', 'jpeg') }

      it 'returns an invalid request' do
        expect(request.valid?).to be_falsey
      end
    end
  end

  # https://channaly.medium.com/how-to-work-with-active-storage-attachment-in-rspec-23bcc49712d6
  def image_for_upload(filename, type)
    file = Rails.root.join('spec', 'support', filename)
    ActiveStorage::Blob.create_after_upload!(
      io: File.open(file, 'rb'),
      filename: filename,
      content_type: "image/#{type}"
    ).signed_id
  end
end