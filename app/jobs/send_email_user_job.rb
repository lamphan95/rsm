class SendEmailUserJob < ApplicationJob
  queue_as :default

  def perform content, company, title, email, email_sender, access_token
    SendmailService.send_mail_by_gmail content,
      company, title, email, email_sender, access_token
  end
end
