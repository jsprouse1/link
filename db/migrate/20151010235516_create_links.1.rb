class CreateLinks < ActiveRecord::Migration
  def up
    create_table :links do |t|
      t.string :author
      t.string :link
      t.text :comment
    end
  end

  def down
    drop_table :links
  end
end
