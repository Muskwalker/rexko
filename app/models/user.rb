class User < ActiveRecord::Base
  serialize :recent
  
  # Defaults.
  # "Recent" represents up to three recent dictionaries
  after_initialize do |user|
    user.recent ||= Array.new(3);
  end
  
  # Update the user's recent dictionaries with an array of +dictionaries+
  def update_recent dictionaries
    dictionaries.each do |dict|
      unless recent.include?(dict)
        recent.pop
        recent.unshift(dict)
      end
    end
    
    save
  end
end
