# Contributing

In order to get started, you need to install [yarn](https://yarnpkg.com/),
[git](https://git-scm.com/) (yeah, it's actually a dependency) and a proper ruby
development environment (with bundler already installed). Then, you can simply
fetch dependencies like so:

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

## Testing

Before submitting a Pull Request, make sure that tests are passing. This can be
checked by running:

```
$ bundle exec rubocop
$ bundle exec rake
```

## Deploying

This is already handled through a Github action, so don't worry about it.
