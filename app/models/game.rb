class Game < ApplicationRecord
	enum :status, [ :pending, :runing, :completed, :rejected]
	
end
