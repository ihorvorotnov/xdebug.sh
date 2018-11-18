# Xdebug.sh

Toggle Xdebug PHP extension on and off, from command line.

![Screencast](screenshot.gif)

## Requirements

- macOS
- [Homebrew](https://github.com/Homebrew/brew)
- PHP installed via Homebrew
- Xdebug extension installed via PECL
- [Laravel Valet](https://github.com/laravel/valet) as your local development environment

## Additional Assumptions

- Extensions config files are located in `/usr/local/etc/php/7.2/conf.d/` dir
- Xdebug extension config file name is `ext-xdebug.ini`

Both assumptions are planned to be removed in next update.

## Installation

1. Clone this repo somewhere
2. `cd` into the dir
3. `chmod a+rx xdebug.sh` 
4. Create symlink `ln -s /path/to/xdebug.sh /usr/local/sbin/xdebug`
5. Run `xdebug help`

## Update

1. `cd` into the dir
2. Run `git pull`

## Plans

- [x] Add GIF screenshot
- [ ] Add automatic config discovery
- [ ] Make in installable via Homebrew