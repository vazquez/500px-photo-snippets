class Snippet
  include Mongoid::Document

  field :username, type: String
  field :photos, type: Array
end
