
class Subject < ActiveRecord::Base

  #on peut supprimer les page connexe
  #quand un sujet sera supprimer
  # has_many :pages, dependent: :destroy
  has_many :pages

  acts_as_list

  validates_presence_of :name
  validates_length_of :name, maximum: 255

  scope :visible, lambda { where(visible: true) }
  scope :invisible, lambda { where(visible: false) }
  scope :sorted, lambda { order('subjects.position ASC')}
  scope :search, lambda { |query| where('name LIKE ?', "%#{query}%")}

end
