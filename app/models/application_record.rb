class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include ActiveModel::Validations
end
