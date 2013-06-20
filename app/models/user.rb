require 'pp'

class User < ActiveRecord::Base
  attr_accessible :name, :oauth_token, :uid
  
  def self.config
    @config ||= if ENV['fb_client_id'] && ENV['fb_client_secret'] && ENV['fb_scope'] && ENV['fb_canvas_url']
      {
        :client_id     => ENV['fb_client_id'],
        :client_secret => ENV['fb_client_secret'],
        :scope         => ENV['fb_scope'],
        :canvas_url    => ENV['fb_canvas_url']
      }
    else
      YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env].symbolize_keys
    end
    rescue Errno::ENOENT => e
    raise StandardError.new("config/facebook.yml could not be loaded.")
	end

  def self.auth(redirect_uri = nil)
    FbGraph::Auth.new config[:client_id], config[:client_secret], :redirect_uri => redirect_uri
  end

  def self.identify(fb_user)
    _uid_ = fb_user.identifier.try(:to_s)
    _user_ = User.find_by_uid(_uid_)

    if !_user_
      _user_ = User.new
    end
    
    _user_ = User.find_or_create_by_uid(_uid_)

    _user_.name = fb_user.name
    _user_.oauth_token = fb_user.access_token.access_token
    
    #_user_.img = fb_user.picture
    #_user_.email = fb_user.email

    _user_.save!
    return _user_
  end

end
