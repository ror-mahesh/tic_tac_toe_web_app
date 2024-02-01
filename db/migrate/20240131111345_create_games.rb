class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :x_player_name
      t.string :o_player_name 
      t.integer :status
      t.json :board
      t.string :current_player, default: 'O'
      t.string :winner
      t.timestamps
    end
  end
end
