class Document < ActiveRecord::Base
  belongs_to :user
  include DocumentsHelper

  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
      self.documentname = File.basename(@file.original_filename)
      self.documenttype = @file.content_type
      self.storedfile_name = upload_file(user_id, @file)
    end
  end

end
