class Club < ApplicationRecord
	validates_presence_of :name, :created_by
end
