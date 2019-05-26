require "nicetitle/version"
require "nicetitle/titlecase"

class Nice
  def self.title(str)
    Nicetitle::Titlecase.titlecase(str)
  end
end
