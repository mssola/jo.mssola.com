# jo

Files for my personal website. In order to get started, you need to install
[yarn](https://yarnpkg.com/) and you need a proper ruby development environment
(with bundler already installed). Then, you can simply fetch dependencies like
so:

```
$ yarn
$ bundle
```

After that, build Javascript files with:

```
$ yarn run webpack
```

And in another session start Jekyll with:

```
$ bundle exec jekyll serve
```

If you just want to **deploy**, simply run:

```
$ ./script/build.sh
```

This will write everything into a `_site` directory. Use this directory to serve
all files.

## License

This project is licensed under the AGPLv3. See [LICENSE](./LICENSE) for the full
license text.
