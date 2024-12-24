class CreateExternalRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :external_requests do |t|
      t.integer :reconcilable_id
      t.string :reconcilable_type
      t.string :url

      t.string :request_method

      t.string :request_headers
      t.string :request_body

      t.string :response_headers
      t.string :response_body

      t.string :response_code

      t.string :event
      t.decimal :duration, precision: 10, scale: 3

      t.timestamps
    end
  end
end
