class User < ActiveRecord::Base
  has_many :suspensions

  def suspended?
    suspensions.active.any?
  end

  def suspend!
    suspensions.create!
  end

  def self.suspend!(ids)
    users = where(id: ids)
    users.each(&:suspend!)
    users
  end
end
