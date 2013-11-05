module RedmineProjectSpecificEmailSender
  class Interceptor
    def self.delivering_email(message)
      if sender = message.header['X-Redmine-Project-Specific-Sender']
        message.from = [sender.to_s]
        message.header['X-Redmine-Project-Specific-Sender'] = nil
      end
    end
  end
end
