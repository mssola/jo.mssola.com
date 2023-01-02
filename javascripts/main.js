// Copyright (C) 2018-2023 Miquel Sabaté Solà <mikisabate@gmail.com>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Returns the tag from the query string. It will return null if there is no
// query string, or if the tag parameter was not given in it.
function fetchTag() {
  const urlParams = new URLSearchParams(window.location.search);
  const myParam = urlParams.get('tag');
  return myParam;
}

// Filters the list of posts by the given tag. If no posts matched the given
// tag, then a proper message will be displayed.
function filterByTag(tag) {
  let count = 0;
  let found = false;
  let entered = false;

  for (const post of document.getElementsByClassName('post-preview')) {
    found = false;
    entered = true;

    for (const t of post.getElementsByClassName('tag')) {
      if (tag === t.innerHTML) {
        found = true;
        break;
      }
    }

    if (!found) {
      post.style.display = 'none';
    } else {
      count += 1;
    }
  }

  if (entered && count === 0) {
    const msg = document.getElementById('oh-its-empty');
    msg.style.display = 'block';
  }
}

// Shows the "Tag being used..." message.
function showTagBeingUsed(tag) {
  document.getElementById('tag-searched').innerHTML = tag;
  document.getElementById('tag-search-message').style.display = 'block';
}

window.onload = function () {
  const tag = fetchTag();
  if (tag === null) {
    return;
  }

  showTagBeingUsed(tag);
  filterByTag(tag);
};
