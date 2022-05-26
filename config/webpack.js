// Copyright (C) 2018-2022 Miquel Sabaté Solà <mikisabate@gmail.com>
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
//
// This file is based on Gitlab's config/webpack.config.js file.

/* eslint-disable quote-props, comma-dangle, import/no-extraneous-dependencies */

const path = require('path');
const webpack = require('webpack');
const CompressionPlugin = require('compression-webpack-plugin');
const StatsPlugin = require('stats-webpack-plugin');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');

const ROOT_PATH = path.resolve(__dirname, '..');

var config = {
  mode: 'production',

  context: path.join(ROOT_PATH, 'javascripts'),
  entry: { main: './main.js' },

  output: {
    path: path.join(ROOT_PATH, 'javascripts/dist'),
    publicPath: '/javascripts/',
    filename: '[name].min.js'
  },

  plugins: [
    new webpack.NoEmitOnErrorsPlugin(),
    new StatsPlugin('manifest.json', {
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true,
    }),
    new webpack.LoaderOptionsPlugin({
      minimize: true,
      debug: false,
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify('production') },
    }),
    new CompressionPlugin({
      asset: '[path].gz[query]',
    })
  ],

  optimization: {
    minimizer: [
      new UglifyJSPlugin({
        sourceMap: true,
        cache: true,
        parallel: true,
        uglifyOptions: {
          output: {
            comments: false
          }
        }
      })
    ]
  },

  resolve: {
    extensions: ['.js'],
    mainFields: ['jsnext', 'main', 'browser'],
  },

  devtool: 'source-map',

  module: {
    rules: [
      { test: /\.js$/, exclude: /node_modules/, loader: "babel-loader" }
    ]
  }
};

module.exports = config;
