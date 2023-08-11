class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.text 'caption'
      t.string 'location'
      t.integer 'profile_id'
      t.integer 'likes_count', default: 0
      t.integer 'comment_count', default: 0
      t.timestamps
    end
  end
end
