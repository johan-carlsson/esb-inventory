module ConsumerContactsHelper
  def consumer_contact_table_row_url(consumer,consumer_contact)
    if current_user
      consumer_contact_url(consumer,consumer_contact)
    else
      contact_url(consumer_contact.contact)
    end
  end
end
