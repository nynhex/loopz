class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :target_url
      t.integer :clicks,  default: 0
      t.string :snapshot
      t.string :title
      t.string :slug

      t.timestamps
    end
  end
end
