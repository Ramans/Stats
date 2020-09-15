class CreateClickLists < ActiveRecord::Migration[6.0]
    def change
        create_table :click_lists do |t|
            t.string :country
            t.string :client_ip
            t.integer :stat_id
            t.timestamps
        end
    end
end
