class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :short
      t.string :full
      t.string :html_title
      t.integer :counter
      t.datetime :expires_in

      t.timestamps
    end
  end
end
