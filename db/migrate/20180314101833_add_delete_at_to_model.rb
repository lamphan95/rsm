class AddDeleteAtToModel < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :deleted_at, :datetime
    add_column :branches, :deleted_at, :datetime
    add_column :categories, :deleted_at, :datetime
    add_column :projects, :deleted_at, :datetime
    add_column :applies, :deleted_at, :datetime
    add_column :feedbacks, :deleted_at, :datetime
    add_column :appointments, :deleted_at, :datetime
    add_column :notifications, :deleted_at, :datetime
    add_column :reward_benefits, :deleted_at, :datetime
    add_column :project_members, :deleted_at, :datetime
    add_column :microposts, :deleted_at, :datetime
    add_column :friends, :deleted_at, :datetime
    add_column :reports, :deleted_at, :datetime
    add_column :relationships, :deleted_at, :datetime
    add_column :inforappointments, :deleted_at, :datetime
    add_column :company_activities, :deleted_at, :datetime
    add_column :partners, :deleted_at, :datetime
    add_column :templates, :deleted_at, :datetime
    add_column :company_settings, :deleted_at, :datetime
    add_column :apply_statuses, :deleted_at, :datetime
    add_column :questions, :deleted_at, :datetime
    add_column :answers, :deleted_at, :datetime
    add_column :email_sents, :deleted_at, :datetime
    add_column :offers, :deleted_at, :datetime
    add_column :surveys, :deleted_at, :datetime
    add_column :currencies, :deleted_at, :datetime
  end
end
