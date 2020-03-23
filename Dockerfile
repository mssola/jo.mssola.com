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

FROM opensuse/leap:15.0
MAINTAINER Miquel Sabaté Solà <mikisabate@gmail.com>

RUN useradd --no-create-home --shell /dev/null --system nobody && \
    zypper ar -f -G obs://home:/mssola/openSUSE_Leap_42.3/ home:mssola && \
    zypper ar -f -G obs://devel:/languages:/nodejs/openSUSE_Leap_15.0/ devel:languages:nodejs && \
    zypper ref && \
    zypper -n in -t pattern devel_basis && \
    zypper -n in nodejs10 npm10 ruby2.5-devel ruby2.5-rubygem-bundler libxslt-devel gcc-c++ glibc-locale git-core && \
    zypper -n in --from home:mssola yarn && \
    npm install -g webpack webpack-cli && \
    zypper clean -a
