class Document < ActiveRecord::Base
  include DocumentsHelper

  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
      self.documentname = File.basename(@file.original_filename)
      self.documenttype = @file.content_type
      self.storedfile_name = upload_file(@file)
    end
  end

end
