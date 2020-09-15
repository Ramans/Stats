class CreateClickLists < ActiveRecord::Migration[6.0]
  def change
    create_table :click_lists do |t|

      t.timestamps
    end
  end
end
