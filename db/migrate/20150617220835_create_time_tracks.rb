class CreateTimeTracks < ActiveRecord::Migration
  def change
    create_table :time_tracks do |t|
      t.references :task, index: true, foreign_key: true
      t.decimal :time_in_minutes, precision: 5, scale: 2, default: 0.0
      t.datetime :date

      t.timestamps null: false
    end
  end
end
