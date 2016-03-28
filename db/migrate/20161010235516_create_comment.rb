class CreateComment < ActiveRecord::Migration
  def up
    create_table :comment do |t|
      t.string :link
      t.text :comment
    end
    add_reference :links, :comment
  end

  def down
    drop_table :comment
  end
end
