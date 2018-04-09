class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
			t.integer :artist_id
			t.text :name
			
      t.timestamps
    end
  end
end
