class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  INDEX_DISPALY_NUM = 9.freeze
  SHOW_DISPLAY_NUM = 5.freeze
end
