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

  describe 'after_create' do
    let!(:request) { Request.new(input_image: image) }

    context 'when the image is readable' do
      let!(:image) { image_for_upload('vegan_quote.png', 'png') }
      let!(:trimmed_expected_text) do
        expected_text = <<~HEREDOC
          VEGAN.
          BECAUSE IT’S A POWERFUL STEP
          WE CAN TAKE IN MAKING
          THIS WORLD A MORE
          PEACEFUL PLACE.
        HEREDOC
        expected_text.delete("\n").delete("\f")
      end

      it 'updates intermediate_text field to the expected text' do
        expect(request.intermediate_text).to be_nil
        request.save
        trimmed_intermediate_text =
          request.intermediate_text.delete("\n").delete("\f")

        expect(trimmed_intermediate_text).to eq(trimmed_expected_text)
      end

      it 'sets output_audio to non-nil value' do
        expect(request.output_audio.attached?).to be_falsey
        request.save
        expect(request.output_audio.attached?).to be_truthy
      end
    end
  end
end