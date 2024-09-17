#!/usr/bin/env ruby
# frozen_string_literal: true

require 'erb'

if ARGV.size != 1
  puts 'Yo! Just one argument which is the file path.'
  exit 1
end

##
# Utility methods.

# Returns a string with the proper url for the given path. This is always needed
# so the subpath is always applied if available.
def url_for(path)
  first = ARGV.first.split('/')[1]

  default = if %w[en posts].include?(first)
              '../'
            else
              ''
            end

  ENV.fetch('JO_SUBPATH', default) + path
end

# Returns a string with the path of the currently evaluated string but without
# the first directory (e.g. so it's 'en/index.html' instead of
# 'build/en/index.html').
def current_path
  ARGV.first.split('/')[1..].join('/')
end

# Returns a string with the url moved into the given language code.
def url_set(lang)
  path = if lang == 'ca'
           current_path.split('/')[1..].join('/')
         else
           "#{lang}/#{current_path}"
         end

  url_for(path)
end

# Returns the language to be used for the current path.
def current_lang
  case current_path.split('/').first
  when 'en'
    'en'
  else
    'ca'
  end
end

# Returns whether there is an english version of the page.
def english_available?
  !%w[posts/zelda.html].include?(current_path)
end

# Returns the class to be used for the <main> element.
def main_class
  if current_path.start_with?('posts/')
    'post'
  end
end

##
# Hash with meta strings for each path.

META = {
  'cv.html' => {
    title: 'Miquel Sabaté Solà - CV',
    description: 'El meu Curriculum Vitae'
  },
  'license.html' => {
    title: 'Miquel Sabaté Solà - Llicència',
    description: 'Llicència d\'aquest espai web'
  },
  'en/index.html' => {
    title: 'Miquel Sabaté Solà - Home page',
    home: 'Home page',
    locale: 'en_US',
    locale_alternate: 'ca_ES'
  },
  'en/cv.html' => {
    title: 'Miquel Sabaté Solà - CV',
    description: 'My CV',
    home: 'Home page',
    locale: 'en_US',
    locale_alternate: 'ca_ES'
  },
  'en/license.html' => {
    title: 'Miquel Sabaté Solà - License',
    description: 'License of this site',
    home: 'Home page',
    locale: 'en_US',
    locale_alternate: 'ca_ES'
  },
  'posts/zelda.html' => {
    title: 'Miquel Sabaté Solà - Sobre \'The Legend of Zelda\'',
    description: 'Entrada sobre la saga de videojocs \'The Legend of Zelda\''
  },
}.fetch(current_path, {})

##
# Behold the complexity of my build!

# Load the current path and evaluate it as an ERB file.
template = ERB.new(IO.read(ARGV.first))
inner_html = template.result(binding)

# Load the layout file as an ERB file and apply all the bindings, which include
# `inner_html` with the file that we previously evaluated.
template = ERB.new(IO.read('src/templates/layout.html.erb'))

# Re-write the file we were evaluating with the new data.
File.write(ARGV.first, template.result(binding))
