class AddUniqIndexToShortUrl < ActiveRecord::Migration[6.1]
  def up
    add_index :shorteners, :short_url, :unique => true
  end

  def down
    
  end
end
