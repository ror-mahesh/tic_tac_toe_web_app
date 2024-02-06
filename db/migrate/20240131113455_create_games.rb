class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :x_player_name
      t.string :o_player_name
      t.integer :status, default: 0
      t.json :board, default: {}
      t.string :result
      t.string :turn

      t.timestamps
    end
  end
end
