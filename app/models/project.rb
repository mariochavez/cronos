class Project < ActiveRecord::Base
  has_many :tasks

  def as_json(options = {})
    {
      id: id,
      name: name,
      active: active
    }
  end
end
