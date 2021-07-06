# frozen_string_literal: true

# Copyright (C) 2019-2020 Miquel Sabaté Solà <mikisabate@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

require_relative 'render_helper'

module Jekyll
  # Render the OG image meta HTML tag for the currently rendered page.
  class RenderOGImageTag < Liquid::Tag
    include ::Jekyll::RenderHelper

    # The path to be used when the current page does not have a specific image.
    DEFAULT_PATH = '/images/default.png'

    def render(context)
      img  = "#{normalize(context['raw_title'])}.png"
      path = image_exists?(img) ? "/images/posts/#{img}" : DEFAULT_PATH
      render_meta('og:image', "http://jo.mssola.com#{path}") +
        render_meta('og:image:width', 630) +
        render_meta('og:image:height', 315) +
        render_meta('twitter:image', "http://jo.mssola.com#{path}", name: true)
    end

    protected

    # Returns true if the given image exists inside of /images/posts.
    def image_exists?(image)
      return false if image == '.png'

      path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'images', 'posts', image))
      File.file?(path)
    end

    # Downcases the given string and replaces space characters with "-"
    def normalize(str)
      str.gsub(/\s/, '-').downcase
    end
  end
end

Liquid::Template.register_tag('render_og_image', Jekyll::RenderOGImageTag)
