class Suspension < ActiveRecord::Base
  belongs_to :user

  before_create {|suspension| suspension.imposed_at = Time.now }

  def self.active
    where(lifted_at: nil)
  end
end
