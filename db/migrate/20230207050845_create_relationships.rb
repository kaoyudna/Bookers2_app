class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      # t.references :follower, null: false #, foreign_key: true
      # t.references :followed, null: false #, foreign_key: true

      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
  end
end
