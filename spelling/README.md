# Purpose

The spelling script reads words from a file, takes 20 of them, and uses OSX's
built in 'say' command to say the word, optionally offering an explanation to
help distinguish homonyms.

I've used this both for my first grader who likes spelling, and my third
grader who's practicing for a spelling bee.

# Installation

Again, install the colorize gem.

Then create a file of words you want to spell. One line per word. If you want
to offer an explanation, add a : after the word and whatever text you want to
say.

Look at 'evie' or 'nate' for examples.

# Running

Replace 'evie' with whatever your wordfile is called:

    ./spelling.rb evie
