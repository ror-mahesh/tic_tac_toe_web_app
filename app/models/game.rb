class Game < ApplicationRecord
  enum :status, [:panding , :running , :completed, :rejected] 
  default_scope { where.not(status: 'rejected')}
end
