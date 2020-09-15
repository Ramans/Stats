class CreateStats < ActiveRecord::Migration[6.0]
    def change
        create_table :stats do |t|
            t.text :url
            t.string :shorten_url
            t.timestamps
        end
    end
end
