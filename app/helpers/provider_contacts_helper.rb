module ProviderContactsHelper
  def provider_contact_table_row_url(provider,provider_contact)
    if current_user
      provider_contact_url(provider,provider_contact)
    else
      contact_url(provider_contact.contact)
    end
  end
end
