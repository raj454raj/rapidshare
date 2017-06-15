class User < ActiveRecord::Base
  attr_accessor :password
  validates_presence_of :password
  validates_presence_of :email
  validates_uniqueness_of :email
  before_save :encrypt_password
  has_many :documents, :dependent => :destroy

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    hash_secret = BCrypt::Engine.hash_secret(password, user.password_salt)
    return (user && user.password_hash == hash_secret) ? user : nil
  end
end
