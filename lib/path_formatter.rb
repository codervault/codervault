module PathFormatter
  #Replace whitespace with -
  #/user1/Quicksort-Algorithim
  def to_param
    name.gsub(' ', '-')
  end

  # Remove leading and trailing whitespaces before save
  def format_name
    name.strip!
  end

  def find_snippet(name)
    name.gsub!('-', ' ')
    snippets.find_by_name(name)
  end
end