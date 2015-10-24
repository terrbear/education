# Purpose

This was used to explain how you teach a machine to do something (for the
vertical and horizontal cases; diagonals are beyond my third grader, or at
least how I solved them).

I had my son give me rules I could use to find a word whose location he knew,
but with the constraint that I had another word find puzzle on another sheet
that he couldn't see. If his rules led to me finding the word, it worked,
if not, he had his first bug.

# Installation

You'll need to install the colorize gem. Look at the example wordsearch files
(nate.txt and freshprince.txt) to see how to format your word search (just write
the wordsearch how it looks on your paper). Write the wordsearch file in ALL CAPS.

# Running

Then, run it this way:

    ruby wordsearch.rb <puzzle text file> <word to find>

Example:

    ruby wordsearch.rb freshprince.txt willsmith
