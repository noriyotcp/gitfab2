class Collaboration < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
belongs_to :project

validates :project, presence: true
end
