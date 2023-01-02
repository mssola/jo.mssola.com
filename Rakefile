# frozen_string_literal: true

# Copyright (C) 2018-2023 Miquel Sabaté Solà <mikisabate@gmail.com>
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

abort('Please run this using `bundle exec rake`') unless ENV['BUNDLE_BIN_PATH']
require 'html-proofer'

desc 'Test the website'
task :test do
  options = {
    check_sri:       true,
    check_html:      true,
    check_img_http:  true,
    check_opengraph: true,
    url_ignore:      [/uoc.edu/],
    typhoeus:        {
      timeout: 120
    },
    cache:           { timeframe: { external: '30d' } }
  }

  dir = ENV.fetch('BUILD_DEST', './_site')
  HTMLProofer.check_directory(dir, options).run
end

task default: [:test]
