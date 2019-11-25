# word-guess

The operation of this little script is based on https://hryanjones.com/guess-my-word/, although I didn't use the code itself at all. I just saw it and thought "I bet I could write a CLI version of that", and I don't feel that way very often, so I decided to try it.

It's not exactly the same:

* it doesn't have an easy mode.
* it doesn't have the cool way of showing all your guesses, though it does show the two most recent on either side.

I think it's pretty okay, though! It does have a basic timer, require your guesses to be words, and let you configure what word list to use. If you don't have `/usr/dict/words` or `/usr/share/dict/words`, you can provide a path to a word list file of similar format in `config`.

