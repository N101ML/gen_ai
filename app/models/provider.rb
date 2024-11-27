class Provider < ApplicationRecord
  has_many :provider_links, dependent: :destroy
  has_many :base_models, through: :provider_links, source: :linkable, source_type: "BaseModel"
  has_many :fine_tunes, through: :provider_links, source: :linkable, source_type: "FineTune"

  validates :name, presence: true, uniqueness: true
end
