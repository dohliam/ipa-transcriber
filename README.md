# IPA Transcriber - Auto-transcribe arbitrary languages into phonemic IPA

This Ruby script leverages the IPA dictionary databases from the [ipa-dict](https://github.com/open-dict-data/ipa-dict) project to automatically convert orthographic text in a variety of languages into phonemic transcription in the International Phonetic Alphabet (IPA).

Take the following text (from [here](https://global-asp.github.io/storybooks-sah/stories/en/0004/)) for example:

    Goat, Dog, and Cow were great friends. One day they went on a journey in a taxi.

Using the English (US) dictionary, this would be converted to:

    ˈɡoʊt ˈdɔɡ ˈænd ˈkaʊ ˈwɝ ˈɡɹeɪt ˈfɹɛndz ˈwən ˈdeɪ ˈðeɪ ˈwɛnt ˈɑn ˈeɪ ˈdʒɝni ˈɪn ˈeɪ ˈtæksi

Results are adjustable using optional custom vocabulary lists.

## Requirements

Since Ruby's inbuilt `.upcase` and `.downcase` methods don't support non-ASCII text, this script requires the alternative versions provided by the UnicodeUtils package:

    gem install unicode_utils

## Usage

To convert some text in a file, just execute `ipa_transcriber.rb` and provide an input file and IPA dictionary to use as a basis for conversion:

    ./ipa_transcriber.rb -f [TEXTFILE] -i [DICTIONARY]

See below for details on command-line options and example invocations.

## Options

The following options are available. The `-f` and `-i` options are mandatory, but `-w` is optional:

* `-f`, `--filename FILE`: _Source file_ (specify a source text file to convert)
* `-i`, `--ipa-dict DICT`: _IPA dictionary file_ (specify the location of the IPA dictionary file to use for the language to convert from)
* `-w`, `--wordlist LIST`: _Optional custom word list_ (an additional list of words and IPA pronunciations to use for words that don't match the provided dictionary file -- e.g., proper names, nonce words, loanwords, etc.)

## Examples

The following examples assume that you have cloned or downloaded and extracted the [ipa-dict](https://github.com/open-dict-data/ipa-dict) to your home folder.

Transcribe some English (US) text into IPA:

    ./ipa_transcriber.rb -f ~/english.txt -i ~/ipa-dict/data/en_US.txt

Transcribe some French (Standard) text into IPA:

    ./ipa_transcriber.rb -f ~/french.txt -i ~/ipa-dict/data/fr_FR.txt

Transcribe some Japanese text into IPA:

    ./ipa_transcriber.rb -f ~/japanese.txt -i ~/ipa-dict/data/ja.txt

## Notes

* The automated IPA transcription will generally need to be manually tweaked in order to disambiguate homographs (e.g., "read" or "bow"), as well as words not found in the IPA dictionary. Some of this work can be aided by using the `-w` option and supplying a custom list of special words used in a particular text.
* Languages whose orthographies do not use spaces to separate words (such as Chinese and Japanese) will need to be manually spaced before converting to IPA. There are tools available that can automate this process to some extent, but their results will need to be carefully reviewed as parsing errors are common.

## Contributing

This project was developed to support the creation of [Storybooks Speech and Hearing](https://global-asp.github.io/storybooks-sah/), and has been used to convert a corpus of stories in more than a dozen languages. PRs and other contributions to expand functionality for other use cases are more than welcome!

## To do

* Allow for one-off conversion of text on the command-line
* Handle conversion of text from STDIN
* Add config file to allow setting default language

## License

MIT.
