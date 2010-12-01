class OAuth2::Provider::Models::Mongoid::AuthorizationCode
  include ::Mongoid::Document
  include OAuth2::Provider::Models::Shared::AuthorizationCode

  field :code
  field :expires_at, :type => Time

  referenced_in :access_grant, :class_name => "OAuth2::Provider::Models::Mongoid::AccessGrant", :inverse_of => :authorization_codes 
  referenced_in :client, :class_name => "OAuth2::Provider::Models::Mongoid::Client"

  before_save do
    self.client = access_grant.client
  end

  def self.find_by_code_and_redirect_uri(code, redirect_uri)
    where(:code => code, :redirect_uri => redirect_uri).first
  end

  def self.find_by_id(id)
    where(:id => id).first
  end

  def self.find_by_code(code)
    where(:code => code).first
  end
end