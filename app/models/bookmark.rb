class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list
  has_rich_text :comment
end
