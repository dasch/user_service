class User < ActiveRecord::Base
  has_many :suspensions

  def suspended?
    suspensions.active.any?
  end

  def suspend!
    suspensions.create!
  end

  def self.suspend!(ids)
    where(id: ids).each(&:suspend!)
  end
end
