class Message

  def self.signature_expired
    'Signature has expired'
  end

  def self.missing_token
    'missing token'
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.pw_confirmation_can_not_be_blank
    "Password confirmation can't be blank"
  end

  def self.account_created
    'Account successfully created'
  end

end
