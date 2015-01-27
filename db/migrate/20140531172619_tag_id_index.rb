class TagIdIndex < ActiveRecord::Migration
  def change
  	add_index :tags, :id, :name => 'tag_id_ix'
  end
end
