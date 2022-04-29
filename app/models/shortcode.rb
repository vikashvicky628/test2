require 'uri'

class Shortcode < ApplicationRecord
    validates :original_url, presence: true,
                             uniqueness: {scope: :original_url, message: "Entry already exists"}

    CHAR_MAP = [*'a'..'z', *'A'..'Z', *'0'..'9'].freeze

    def get_short_url
        shortcode = ""
        if self[:original_url].present?
            x = self[:original_url].length * rand(128...254)
            puts x
            while x > 0
                shortcode = shortcode + CHAR_MAP[x%62]
                x = x/62
            end
        end
        self[:short_url] = shortcode
    end
end
