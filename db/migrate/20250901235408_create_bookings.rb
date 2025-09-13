class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    # تأجيل إنشاء المفتاح الخارجي حتى يتم إنشاء جدول rides
    create_table :bookings do |t|
      t.integer :ride_id, null: false
      t.references :passenger, null: false, foreign_key: { to_table: :users }
      t.integer :seats
      t.integer :status, default: 0
      t.text :notes

      t.timestamps
    end

    # إضافة المفتاح الخارجي لاحقاً
    add_foreign_key :bookings, :rides
  end
end
