class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.binary :input_image
      t.text :intermediate_text
      t.binary :output_audio

      t.timestamps
    end
  end
end
