class Avatar < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  DEFAULT_AVATAR = 'https://www.journalisten-tools.de/wp-content/uploads/2014/07/8BKnRUXg.png'
end
