require_relative '../config'

class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :party
      t.string :state
      t.boolean :in_office
      t.string :gender
      t.string :phone
      t.string :twitter_id
      t.string :birthdate
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end


