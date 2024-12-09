class AddDateToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :date, :datetime
  end
end
