class Render < ApplicationRecord
  belongs_to :modelable, polymorphic: true

  enum status: { pending: 0, processing: 1, completed: 2, failed: 3 }
end
