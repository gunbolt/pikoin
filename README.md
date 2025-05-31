# pikoin

A free and open source finance tracker.

 <img alt="pikoin" src="https://raw.githubusercontent.com/gunbolt/pikoin/HEAD/.github/screenshot.png" style="max-width: 100%;">

In construction...

## Configuration

#### Language

Use the `PIKOIN_LANG` environment variable to set the application's default
locale:

```
PIKOIN_LANG=en bin/dev
```
Default value: `pt-BR`.

Available options: `en`, `pt-BR`.


#### Currency

Use `PIKOIN_CURRENCY` to specify the currency used throughout the application:
```
PIKOIN_CURRENCY=USD bin/dev
```
Default value: `BRL`.

Available options: Currencies supported by [Money](https://github.com/RubyMoney/money) gem.

## Contributing

Bug reports are welcome on GitHub at https://github.com/gunbolt/pikoin. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/gunbolt/pikoin/blob/master/CODE_OF_CONDUCT.md).

Please always open a new issue before sending a pull request if you want to add a new feature to pikoin, unless it is a minor fix, and wait until someone from the core team approves it before you actually start working on it. Otherwise, you risk having the pull request rejected, and the effort implementing it goes to waste. And if you start working on an implementation for an issue, please let everyone know in the comments so someone else does not start working on the same thing.

## License

pikoin is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Gunbolt's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/gunbolt/pikoin/blob/master/CODE_OF_CONDUCT.md).
