class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :text
      t.boolean :done
      t.integer :notification_type
      t.datetime :due_date
      t.timestamps
    end
  end
end
