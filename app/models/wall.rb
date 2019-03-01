class Wall < ApplicationRecord
  belongs_to :wallable, polymorphic: true
end
