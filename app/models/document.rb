class Document < ActiveRecord::Base

  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
      self.documentname = File.basename(@file.original_filename)
      self.documenttype = @file.content_type
      self.contents = @file.read
    end
  end

end
