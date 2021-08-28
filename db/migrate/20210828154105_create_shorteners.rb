class CreateShorteners < ActiveRecord::Migration[6.1]
  def change
    create_table :shorteners do |t|
      t.string :full_url
      t.string :short_url
      t.string :html_title
      t.integer :counter
      t.datetime :expires_in

      t.timestamps
    end
  end
end
