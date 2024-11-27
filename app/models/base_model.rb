class BaseModel < ApplicationRecord
  has_many :fine_tunes, dependent: :destroy
  has_many :provider_links, as: :linkable, dependent: :destroy
  has_many :providers, through: :provider_links
  has_many :renders, as: :modelable, dependent: :destroy

  validates :name, presence: true
end
