class AdminUser < ActiveRecord::Base

  has_secure_password

  #to configure rails with different table name
  #self.table_name = 'admin_users'
  has_and_belongs_to_many :pages, join_table: 'admin_users_pages'
  has_many :section_edits
  has_many :sections, through: 'section_edits'

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = ['littlebopeep', 'humptydumpty', 'marymary']

  validates :first_name, presence: true,
                       length: {maximum: 25}
  validates :last_name, presence: true,
                      length: {maximum: 50}
  validates :username, length: {within: 8..25},
                     uniqueness: true
  validates :email, format: {with: EMAIL_REGEX},
                  confirmation: true,
                  length: {:maximum => 100}
  validate :username_is_allowed
  #validate :no_new_users_on_saturday, :on => :create

  scope :sorted, lambda {order('admin_users.first_name asc, admin_users.last_name asc')}

  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, 'has bin restricted from use.')
    end
  end

  # Errors not related to a specific attribute
  # can be added to errors[:base]
  def no_new_users_on_saturday
    if Time.now.wday == 6
      errors[:base] << "No new users on Saturdays."
    end
  end

  def name
    first_name+' '+last_name
  end

end

