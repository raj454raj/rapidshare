module DocumentsHelper
  def upload_file(user_id, actual_file)
    filename = File.basename(actual_file.original_filename)
    uploads_directory = "public/uploads"
    FileUtils.mkdir(uploads_directory) if !File.directory?(uploads_directory)
    directory = File.join(uploads_directory, user_id.to_s)
    FileUtils.mkdir(directory) if !File.directory?(directory)

    while File.exists?(File.join(directory, filename))
      if filename.include?("___")
        number = filename.match(/\d___/).to_s
        if number.empty?
          filename = "1___" + filename
        else
          number = number[0...-3].to_i + 1
          parts = filename.split("___")
          parts[0] = number.to_s
          filename = parts.join("___")
        end
      else
        filename = "1___" + filename
      end
    end
    path = File.join(directory, filename)
    File.open(path, "wb") { |f| f.write(actual_file.read) }
    return filename
  end
end