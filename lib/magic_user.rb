require "magic_user/version"

module MagicUser
  extend ActiveSupport::Autoload
  autoload :Userstamp
  
  ActiveRecord::Base.class_eval do
    include Userstamp
  end
end
