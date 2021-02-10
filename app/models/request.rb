class Request < ApplicationRecord
  has_one_attached :input_image, dependent: :destroy

  # TODO: figure out how to validate size
  validates :input_image, presence: true
  validate :input_image_mime_type

  private

  def input_image_mime_type
    return unless input_image.attached?

    return if input_image.content_type == 'image/png'

    errors.add(:input_image, 'Must be a png')
  end
end