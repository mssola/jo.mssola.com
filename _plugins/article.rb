# frozen_string_literal: true

# Copyright (C) 2019 Miquel Sabaté Solà <mikisabate@gmail.com>
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

require "time"
require_relative "render_helper"

module Jekyll
  # Render og:type related tags.
  class RenderTypeTags < Liquid::Tag
    include ::Jekyll::RenderHelper

    def render(context)
      if ["posts"].include?(context["page"]["collection"])
        render_article_tags(context["page"])
      else
        '<meta property="og:type" content="website" />'
      end
    end

    protected

    # Render all the tags related to the article og:type.
    def render_article_tags(page)
      tags = page["tags"].inject("") { |acc, t| acc + render_meta("article:tag", t) }

      '<meta property="og:type" content="article" />' +
        render_meta("og:author", "Miquel Sabaté Solà") +
        render_meta("profile:first_name", "Miquel") +
        render_meta("profile:last_name", "Sabaté Solà") +
        render_meta("profile:username", "mssola") +
        render_meta("profile:gender", "male") +
        render_meta("article:section", page["collection"]) +
        render_meta("article:published_time", published_time(page)) +
        render_meta("article:modified_time", modified_time(page)) +
        tags
    end

    # Returns the published time of the given page.
    def published_time(page)
      # We could do fancy stuff like using DateTime.strptime and so on, but
      # Jekyll completely disregards the hour, minutes, etc., so why bother.
      page["date"].to_s.split.first
    end

    # Returns the modified time of the given page.
    def modified_time(page)
      path = File.expand_path(File.join(File.dirname(__FILE__), "..", page["path"]))
      out  = `git log -n 1 --pretty='format:%cd' --date=iso8601-strict -- #{path}`

      begin
        Time.iso8601(out)
        out
      rescue ArgumentError => e
        puts "[WARNING] Could not parse the given modified time from Git: #{e}"
        nil
      end
    end
  end
end

Liquid::Template.register_tag("render_type_tags", Jekyll::RenderTypeTags)
