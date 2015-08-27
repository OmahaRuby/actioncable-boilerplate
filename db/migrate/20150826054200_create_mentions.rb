class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.belongs_to :thought, index: true, foreign_key: true
      t.belongs_to :mentioned, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
