class AddUserPassword < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :encrypted_password
  		t.string :salt
  		t.rename :name, :username
  	end
  end
end
