class CreateLinks < ActiveRecord::Migration
  
def change
    create_table :links do |t|
      t.string :linkAuthor
      t.string :linkAddress
    end
end
end
