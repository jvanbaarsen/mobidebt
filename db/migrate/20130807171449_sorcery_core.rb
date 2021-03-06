class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,            :default => nil
      t.string :name,             :default => nil
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.integer :credits,         :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
