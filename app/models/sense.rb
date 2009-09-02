class Sense < ActiveRecord::Base
  belongs_to :subentry
  delegate :lexeme, :to => '(subentry or return nil)' 
  belongs_to :language
  has_many :glosses
  has_many :interpretations
  has_many :parses, :through => :interpretations
  
  accepts_nested_attributes_for :glosses, :parses, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
  
protected
  def validate
    if definition.blank? && glosses.empty?
      errors.add_to_base("Definition or gloss must be supplied for a sense") 
    end
  end
end