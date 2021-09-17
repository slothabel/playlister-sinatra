class SongGenre < ActiveRecord::Base
    belongs_to :song
    belongs_to :genre

    def slug
        name.downcase.gsub(" ","-")
      end
    
      def self.find_by_slug(slug)
        SongGenre.all.find{|sg| sg.slug == slug}
      end

    
end

