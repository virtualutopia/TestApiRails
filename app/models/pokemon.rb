class Pokemon < ApplicationRecord
    validates :Name, presence: true
end
