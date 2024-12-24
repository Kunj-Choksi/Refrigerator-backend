class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.text :body
      t.string :message_type

      t.timestamps
    end
  end
end
