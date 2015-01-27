class UserHasVideo < ActiveRecord::Migration
  def change
  	change_table :videos do |t|
  		t.belongs_to :user
  	end
  end
end
