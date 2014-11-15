require 'rfc822'

class FormHelper

  def cleanHash (request)
    nomes = request['nome'].values
    emails = request['email'].values
    Hash[nomes.zip emails].delete_if { |nome, email|
      nome.nil? || email.nil? ||
      nome.empty? || email.empty? || !email.is_email?
    }
  end
end
