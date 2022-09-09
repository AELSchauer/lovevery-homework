class CreateGifts < ActiveRecord::Migration[6.0]
  def change
    create_table :gifts do |t|
      t.references :child, null: false, foreign_key: true, comment: "Which child is this for?"
      t.references :order, null: false, foreign_key: true, comment: "Which order is this for?"
      t.string :purchaser_name, null: false, comment: "The name of the gift giver"
      t.string :purchaser_email, null: false, comment: "The email for the gift giver"
      t.text :gift_message, comment: "The gift giver's message the recepient (optional)"

      t.timestamps
    end
  end
end
