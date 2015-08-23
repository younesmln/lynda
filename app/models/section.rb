class Section < ActiveRecord::Base
  belongs_to :page
  has_many :section_edits
  has_many :editors, through: 'section_edits', class_name: 'AdminUser'

  acts_as_list scope: :page

  after_save :touch_page

  CONTENT_TYPE = ['text', 'html']
  validates_presence_of :name
  validates_length_of :name, maximum: 255
  validates_inclusion_of :content_type, in: CONTENT_TYPE, message: "must be one of: #{CONTENT_TYPE.join(' ')} "
  validates_presence_of :content


  scope :sorted, lambda { order('sections.position ASC')}

  private
    def touch_page
      page.touch
    end

end
