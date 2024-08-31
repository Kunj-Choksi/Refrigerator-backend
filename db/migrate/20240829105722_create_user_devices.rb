class CreateUserDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :user_devices do |t|
      t.references :user
      t.string :fcm_token
      t.string :device_type

      t.timestamps
    end
  end
end
