class FineTune < ApplicationRecord
  belongs_to :base_model
  has_many :provider_links, as: :linkable, dependent: :destroy
  has_many :providers, through: :provider_links
  has_many :renders, as: :modelable, dependent: :destroy

  validates :name, presence: true
end
