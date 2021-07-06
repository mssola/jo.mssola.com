# frozen_string_literal: true

# Copyright (C) 2019-2021 Miquel Sabaté Solà <mikisabate@gmail.com>
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

module Jekyll
  # RenderHelper implements methods that help other plugins to render HTML code.
  module RenderHelper
    # Render an HTML meta tag with the given property and content
    # attributes. You may optionally pass a `name` argument. When true, it will
    # use "name" instead of "property". Defaults to nil.
    def render_meta(property, content, name: nil)
      if name
        "<meta name=\"#{property}\" content=\"#{content}\" />"
      else
        "<meta property=\"#{property}\" content=\"#{content}\" />"
      end
    end
  end
end
