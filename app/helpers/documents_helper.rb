module DocumentsHelper
  def upload_file(actual_file)
    filename = File.basename(actual_file.original_filename)
    directory = "public/uploads"
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
