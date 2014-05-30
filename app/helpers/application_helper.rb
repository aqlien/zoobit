require "yaml"

module ApplicationHelper
  def title(page_title)
    content_for(:title) {page_title}
  end

  def self.obscene_substring?(word_to_check)
    blacklist = YAML.load_file("config/blacklist.yml")
    blacklist.each do |word|
      return true if word_to_check.downcase.include?(nono)
    end
    return false
  end
end
