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

  def self.email_not_found
    'Mist, diese Emailadresse gibt es nicht'
  end

  def self.reset_instructions_sent
    'We sent you reset instructions'
  end

  def self.perfect
    'Perfect'
  end

  def self.pw_changed
    'Passwort geändert, Bitte hinkünftig besser aufpassen'
  end

  def self.alles_geht_schief
    'Heute geht aber auch alles schief'
  end

  def self.pw_confirmation_not_match
    "Password Confirmation doesn't match"
  end

  def self.deleted
    "deleted"
  end

  def self.no_permission
    'You are not allowed to do that'
  end

end
