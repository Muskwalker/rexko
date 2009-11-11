class Subentry < ActiveRecord::Base
  has_many :etymotheses
  has_many :etymologies, :through => :etymotheses
  belongs_to :lexeme
  belongs_to :language
  has_many :senses
  has_many :notes, :as => :annotatable
  validates_presence_of :paradigm
  
  accepts_nested_attributes_for :senses, :etymologies, :notes, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }
end
