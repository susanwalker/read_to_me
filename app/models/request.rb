class Request < ApplicationRecord
  has_one_attached :input_image, dependent: :destroy
  has_one_attached :output_audio, dependent: :destroy

  # TODO: figure out how to validate size
  validates :input_image, presence: true
  validate :input_image_mime_type

  after_create :convert_image_to_audio

  def convert_image_to_audio
    # first convert image to text, then text to audio
    # https://www.cloudsavvyit.com/8151/how-to-convert-images-to-text-on-the-linux-command-line-with-ocr/
    # https://edgeguides.rubyonrails.org/active_storage_overview.html#downloading-files

    unique_output_name = "output#{id}"
    input_image.open do |file|
      puts "Running tesseract command: tesseract -l eng #{file.path} #{unique_output_name}"
      `tesseract -l eng #{file.path} #{unique_output_name}`
    end

    self.intermediate_text = File.read("#{unique_output_name}.txt")

    # Clean up (We don't need the intermediate file)
    File.delete("#{unique_output_name}.txt")

    save
  end

  private

  def input_image_mime_type
    return unless input_image.attached?

    return if input_image.content_type == 'image/png'

    errors.add(:input_image, 'Must be a png')
  end
end