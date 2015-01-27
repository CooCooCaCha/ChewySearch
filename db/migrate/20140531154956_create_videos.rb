class CreateVideos < ActiveRecord::Migration
  def change
  	create_table :tag_types do |t|
      t.string :label
      t.timestamps
    end

    create_table :tags do |t|
      t.belongs_to :tag_type
      t.string :label
      t.timestamps
	end

    create_table :videos do |t|
      t.string :title
      t.string :video_url
      t.string :thumb_url
      t.timestamps
    end

    create_table :video_tags do |t|
      t.belongs_to :video
      t.belongs_to :tag
      t.timestamps
    end 
  end
end
