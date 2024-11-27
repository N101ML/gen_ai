class ProviderLink < ApplicationRecord
  belongs_to :provider
  belongs_to :linkable, polymorphic: true

  validates :view_link, :source_link, presence: true
end
