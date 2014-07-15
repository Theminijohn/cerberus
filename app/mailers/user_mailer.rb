class UsersMailer < ActionMailer::Base

  default from: Settings.emails.from.contact, css: ["emails.css"]

  include ApplicationHelper
  helper :application

  include ActionView::Helpers::TextHelper



  def welcome_to_anyroad(user_email, user_name, generated_password=nil, is_guide=false)
    @user_name = user_name
    @generated_password = generated_password rescue nil
    @is_guide = is_guide rescue false
    @from = @is_guide ? Settings.emails.anyguide.from.contact : Settings.emails.from.contact
    mail(to: user_email, from: @from, subject: "Welcome to Any#{@is_guide ? 'Guide' : 'Road'}!")
  end

  def guide_welcome_to_anyroad(user_email, user_name)
    use_vanity_mailer user_email

    @user_name = user_name
    @from = Settings.emails.anyguide.from.contact
    mail(to: user_email, from: @from, subject: "Welcome to AnyGuide!")
  end


  def paused_account(user_email, user_name)
    @user_name = user_name
    mail(to: user_email, subject: "Your AnyRoad account")
  end

  def flagged_alert(user, flagged_by, reason)
    @reason = reason
    @user = user
    @flagged_by = flagged_by
    mail(to: "#{Settings.emails.daniel}, #{Settings.emails.jonathan}", subject: "User was flagged")
  end

  def admin_message_notification(sender, body, conversation)
    @recipients = conversation.participants - [sender]
    @sender  = sender
    @body = body
    @conversation = conversation

    mail(
      to: "#{Settings.emails.jesse}, #{Settings.emails.daniel}",
      subject: "AnyRoad Message from #{sender.public_name} to #{@recipients.map(&:public_name).join(', ')}"
    )
  end

  def sanitize_body(sender, body)
    if sender.admin?
      body
    else
      sanitize(body, tags: %w{}, attributes: %w{})
    end.gsub(/(?:\n\r?|\r\n?)/, '<br>').html_safe
  end

  def message_user(recipient, sender, subject, body, conversation)
    @recipient = recipient
    @sender = sender
    @is_guide = recipient.is_guide?
    @from = @is_guide ? Settings.emails.anyguide.from.contact : Settings.emails.from.contact
    @delimiter = "-- Write above this line to respond to #{@sender.firstname} --"
    @subject = subject
    @body = sanitize_body(sender, body)
    @contact = Contact.where('conversation_id = ?', conversation.id).first rescue nil

    host = recipient.is_guide? ? 'www.anyguide.com' : Settings.url_options.host
    @url = conversation ? conversation_url(conversation, host: host) : mailbox_url(host: host)
    conv_id = conversation ? "-#{conversation.id}" : ''

    mail(
      to: recipient.email,
      from: @from,
      subject: @subject,
      reply_to: "reply-#{recipient.id}-#{SecureRandom.hex(8)}-#{sender.id}#{conv_id}@inbound.anyroad.com"
    )
  end

  def got_response(sender, recipient, receipt, conversation)
    message = receipt.message
    @sender = sender
    @subject = message.subject
    @body = sanitize_body(sender, message.body)
    @contact = Contact.where('conversation_id = ?', conversation.id).first rescue nil
    @recipient = recipient
    @from = @recipient.is_guide? ? Settings.emails.anyguide.from.contact : Settings.emails.from.contact
    host = @recipient.is_guide? ? 'www.anyguide.com' : Settings.url_options.host
    @url = conversation_url(conversation, host: host)

    mail(
      to: @recipient.email,
      from: @from,
      subject: message.subject,
      reply_to: "reply-#{@recipient.id}-#{SecureRandom.hex(8)}-#{@sender.id}-#{conversation.id}@inbound.anyroad.com"
    )
  end

  def new_guide_association_submitted(user, guide_association)
    @user = user
    @guide_association = guide_association
    mail(
      to: "#{Settings.emails.daniel}, #{Settings.emails.jonathan}",
      subject: "New Guide Association submitted"
    )
  end

  def new_guide_association_submitted_v2(user, ga_name, ga_website)
    @user       = user
    @ga_name    = ga_name
    @ga_website = ga_website
    mail(
      to: "#{Settings.emails.daniel}, #{Settings.emails.jonathan}, #{Settings.emails.jesse}",
      subject: "New Guide Association submitted by #{@user.name}, #{@user.id} - #{@ga_name}, #{@ga_website}"
    )
  end

  def tour_amended_alert(guide)
    @title = "Thank you for improving your tours"
    @guide = guide
    @from = Settings.emails.anyguide.from.contact
    mail(to: @guide.email, from: @from, subject: "Thank you for improving your tours")
  end

  def submitted_tour_alert(user, tour)
    @user = user
    @tour = tour
    @subject = if !@user.first_tour_submitted
                "You Submitted Your First Tour!"
              else
                "You submitted #{tour.full_name}"
              end
    @first_tour_submitted = @user.first_tour_submitted
    @from = Settings.emails.anyguide.from.contact
    mail(to: @user.email, from: @from, subject: @subject)
  end

  def submitted_inquiry_alert(inquirer, guide, conversation)
    @inquirer = inquirer
    @guide = guide
    @contact = Contact.where('conversation_id = ?', conversation.id)[0] rescue nil
    host = Settings.url_options.host
    @url = conversation ? conversation_url(conversation, host: host) : mailbox_url(host: host)
    conv_id = conversation ? "-#{conversation.id}" : ''
    @subject = "Inquiry received"

    mail(
      to: inquirer.email,
      subject: @subject,
      reply_to: "reply-#{inquirer.id}-#{SecureRandom.hex(8)}-#{guide.id}#{conv_id}@inbound.anyroad.com"
    )
  end

end
