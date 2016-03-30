class CreateComments < ActiveRecord::Migration
def change
    create_table :comments do |t|
      t.string :comment
      t.belongs_to :links, index: true
    end
end
end
