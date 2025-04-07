class CreateIndexes < ActiveRecord::Migration[8.0]
  def change
    add_index :accounts, %i[archived position]
    add_index :categories, %i[position]
    add_index :templates, %i[position]

    add_index :records, %i[account_id occurred_on created_at],
      order: {occurred_on: :desc, created_at: :desc}

    add_index :records, %i[occurred_on], order: {occurred_on: :desc}
  end
end
