# Wikipedia Philosophy Path Finder

This Ruby script navigates through Wikipedia pages, starting from a given page and following the first link in the main body of the article that is not within parentheses or italicized, aiming to reach the "Philosophy" page. This experiment is based on the observation that, starting from almost any article on Wikipedia, by clicking on the first link not in parentheses or italics, one will eventually end up on the "Philosophy" page.

## Setup

- Install dependencies by running `bundle install`

## Usage

To use this script, you will need Ruby installed on your machine. Once Ruby is installed, you can run the script from the terminal.

### Basic Command

```sh
ruby main.rb -p "StartingPageName"
```

Replace `"StartingPageName"` with the name of the Wikipedia page you want to start from. The script will print each page it jumps to and will stop once it reaches the "Philosophy" page or detects a loop.

### Specifying an End Page

By default, the script aims to reach the "Philosophy" page. However, you can specify a different end page using the `-e` or `--end_page` option:

```sh
ruby main.rb -p "StartingPageName" -e "EndPageName"
```

Replace `"EndPageName"` with the name of the Wikipedia page you wish to end on.

### Help

To view help information and command options, run:

```sh
ruby main.rb -h
```

## Features

- **Custom Start and End Pages**: Start from any Wikipedia page and aim for any end page, not just "Philosophy".
- **Loop Detection**: Detects and avoids infinite loops by skipping already visited pages.
- **Error Handling**: Gracefully handles errors, such as network issues or missing pages.

## Example

Starting from the "Cat" page aiming to reach "Philosophy":

```sh
ruby main.rb -p "Cat"
```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any bugs, feature requests, or improvements.

## License

This project is open-sourced under the MIT License. See the LICENSE file for more information.

#### Note
- This readme was generated with Github Copilot.