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
  # ModifiedTimeHelper offers methods to fetch the modified time of a given page.
  module ModifiedTimeHelper
    # Returns the modified time of the given page.
    def modified_time(page)
      path = File.expand_path(File.join(File.dirname(__FILE__), '..', page['path']))
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
