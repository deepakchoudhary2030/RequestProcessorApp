class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :request_id, index: { unique: true }
      t.text :data
      t.string :status
      t.text :error_message

      t.timestamps
    end
  end
end
