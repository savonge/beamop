class Page < ActiveRecord::Base
before_create :set_url
  belongs_to :user

validates :headline, :presence => true, :length => {
  :maximum => 12,
  :tokenizer => lambda { |str| str.scan(/\w+/) },
  :too_long  => "Headline should be maximum 12 words"
}

validates :content, :length => {
  :maximum => 36,
  :tokenizer => lambda { |str| str.scan(/\w+/) },
  :too_long  => "Content should be maximum 36 words"
}
H1_STYLES = {

["wagon", "accelerator", "innovate", "innovation", "programming", "code", "tech", "start", "bootcamp", "internet", "app"] => "tech",
["fashion", "sale", "clothing", "bags", "shoes", "buotique", "%", "shop", "off", "special", "pants"] => "fashion",
["surf", "vacation", "flight", "hotel", "package", "destination", "destinations", "asia", "america", "europe", "africa" ] => "travel",
["show", "live", "tickets", "concert", "beers", "tour", "venue", "get", "warm up", "warm-up"] => "music",
["class", "lecture", "professor", "topic", "subject","classroom", "university", "campus", "college" ] => "academic",
["love", "wedding", "anniversary", "happy birthday", "wish","kisses", "hugs", "you" ] => "personal"


}


  def style
  @style ||= detect_style(content_for_style, H1_STYLES, "neutral")
  end

def content_for_style
  "#{headline} #{content}".downcase
end


def h1_style
  style+variant
end

def backgroundimage
  "bg-"+style+variant
end

def variant
  rand(1..3).to_s
end

def detect_style(text, rules, default_style)
  rules.each do |keywords, style|
    return style if keywords.any? { |kw| text.include?(kw) }
  end

  default_style
end


def set_url
  self.url = rand(1..1000)

end


end
