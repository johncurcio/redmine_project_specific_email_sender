module RedmineProjectSpecificEmailSender
  module MailerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :mail_from, :project_specific_email
        alias_method_chain :issue_add, :project_specific_email
        alias_method_chain :issue_edit, :project_specific_email
        alias_method_chain :document_added, :project_specific_email
        alias_method_chain :attachments_added, :project_specific_email
        alias_method_chain :news_added, :project_specific_email
        alias_method_chain :message_posted, :project_specific_email
      end
    end

    module InstanceMethods
      def mail_from_with_project_specific_email
        @project ? @project.email : mail_from_without_project_specific_email
      end

      def issue_add_with_project_specific_email(issue)
        @project = issue.project
        issue_add_without_project_specific_email(issue)
      end

      def issue_edit_with_project_specific_email(journal)
        @project = journal.journalized.project
        issue_edit_without_project_specific_email(journal)
      end
      
      def document_added_with_project_specific_email(document)
        @project = document.project
        document_added_without_project_specific_email(document)
      end
      
      def attachments_added_with_project_specific_email(attachments)
        @project = attachments.first.container.project
        attachments_added_without_project_specific_email(attachments)
      end
      
      def news_added_with_project_specific_email(news)
        @project = news.project
        news_added_without_project_specific_email(news)
      end
      
      def message_posted_with_project_specific_email(message)
        @project = message.board.project
        message_posted_without_project_specific_email(message)
      end
    end
  end
end
