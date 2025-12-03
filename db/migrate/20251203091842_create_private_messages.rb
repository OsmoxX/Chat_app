class CreatePrivateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :private_messages do |t|
      t.text :body
      t.references :conversation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
