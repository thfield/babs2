class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.text      :data_dump
      t.integer   :station_id
      t.string    :name
      t.decimal   :lat
      t.decimal   :long
      t.integer   :dockcount
      t.string    :landmark
      t.datet     :installation
      t.text      :notes

      t.timestamps null: false
    end
  end
end
