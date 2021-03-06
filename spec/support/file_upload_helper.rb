module FileUploadHelper
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