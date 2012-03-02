require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare do
  require_dependency 'project'
  require_dependency 'mailer'
  require_dependency 'mail_handler'
  require_dependency 'projects_helper'

  unless Project.included_modules.include? RedmineProjectSpecificEmailSender::ProjectPatch
    Project.send(:include, RedmineProjectSpecificEmailSender::ProjectPatch)
  end

  unless Mailer.included_modules.include? RedmineProjectSpecificEmailSender::MailerPatch
    Mailer.send(:include, RedmineProjectSpecificEmailSender::MailerPatch)
  end

  unless MailHandler.included_modules.include? RedmineProjectSpecificEmailSender::MailHandlerPatch
    MailHandler.send(:include, RedmineProjectSpecificEmailSender::MailHandlerPatch)
  end

  unless ProjectsHelper.include? RedmineProjectSpecificEmailSender::ProjectsHelperPatch
    ProjectsHelper.send(:include, RedmineProjectSpecificEmailSender::ProjectsHelperPatch)
  end
end

Redmine::Plugin.register :redmine_project_specific_email_sender do
  name 'Redmine Project Specific Email Sender plugin'
  author 'Adam Walters'
  description "This is a plugin for Redmine which allows each project to have it's own sender email address for project related, outbound emails"
  version '1.0.0'
  
  permission :edit_project_email, :project_emails => [:update, :destroy]
end
