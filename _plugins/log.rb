# frozen_string_literal: true

# Copyright (C) 2019-2023 Miquel Sabaté Solà <mikisabate@gmail.com>
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

require 'date'
require_relative 'modified_time_helper'

module Jekyll
  # Render the last modification time of the given page. This plugin requires
  # the use of the Jekyll multiple-language plugin, and a value for the
  # 'log.unknown' key.
  class RenderModifiedAt < Liquid::Tag
    include ::Jekyll::ModifiedTimeHelper

    def render(context)
      mt = modified_time(context['page'])
      return unknown(context) if mt.nil?

      time = Time.iso8601(mt)
      if context['page']['lang'] == 'en'
        time.strftime('%B %-d, %Y, at %H:%m')
      else
        time.strftime("%-d de #{catalan_month(time.month)} de %Y, a les %H:%m")
      end
    end

    protected

    # Returns the 'log.unknown' string.
    def unknown(context)
      lang = context['site']['lang']
      ts   = context['site']['translations'][lang]

      ts['log']['unknown']
    end

    # Given a month number, return its catalan translation.
    # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
    def catalan_month(month)
      case month
      when 1
        'gener'
      when 2
        'febrer'
      when 3
        'març'
      when 4
        'abril'
      when 5
        'maig'
      when 6
        'juny'
      when 7
        'juliol'
      when 8
        'agost'
      when 9
        'setembre'
      when 10
        'octubre'
      when 11
        'novembre'
      when 12
        'desembre'
      else
        ''
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity
  end

  # Render the link to git.mssola.com of the given page.
  class RenderLogLink < Liquid::Tag
    include ::Jekyll::ModifiedTimeHelper

    WEBSITE_BASE   = 'https://github.com'
    WEBSITE_REPO   = 'mssola/jo.mssola.com'
    WEBSITE_BRANCH = 'main'

    def render(context)
      page = context['page']
      url  = "#{WEBSITE_BASE}/#{WEBSITE_REPO}/commits/#{WEBSITE_BRANCH}/#{page['relative_path']}"

      if page['lang'] == 'en'
        "<a href=\"#{url}\" title=\"Log for this page\">here</a>"
      else
        "<a href=\"#{url}\" title=\"Historial d'aquesta pàgina (anglès)\">aquí</a>"
      end
    end
  end
end

Liquid::Template.register_tag('render_modified_at', Jekyll::RenderModifiedAt)
Liquid::Template.register_tag('render_log_link', Jekyll::RenderLogLink)
