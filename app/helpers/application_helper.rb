require "yaml"

module ApplicationHelper
  def title(page_title)
    content_for(:title) {page_title}
  end

  def self.obscene_substring?(word_to_check)
    blacklist = YAML.load_file("config/blacklist.yml")
    blacklist.each do |word|
      return true if word_to_check.downcase.include?(word)
    end
    return false
  end

  def avatar_url(user)
    default_url = "#{root_url}images/sally.png"
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=75&d=mm"
  end

end
