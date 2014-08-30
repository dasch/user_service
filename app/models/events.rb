module Events
  class << self
    def signup(user)
      exchange = channel.fanout("users.signups")
      exchange.publish(user.to_json)
    end

    def suspension!(user)
      exchange = channel.fanout("users.suspensions")
      exchange.publish(user.to_json)
    end

    private

    def channel
      @channel ||= $bunny.create_channel
    end
  end
end
