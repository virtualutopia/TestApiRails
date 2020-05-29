class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :Name
      t.string :Type1
      t.string :Type2
      t.integer :Total
      t.integer :HP
      t.integer :Attack
      t.integer :Defense
      t.integer :SpDef
      t.integer :Speed
      t.integer :Generation
      t.boolean :Legendary
      

      # t.timestamps
    end
  end
end
