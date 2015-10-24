# Purpose

These scripts provide ad nauseum arithmetic practice for quizzes offered
in my son's third grade class.

# Installation

Needs colorize.

# Running

I'll add division once we're on it :)

Multiplication, addition, and subtraction all are run simply as (eg):

    ./addition.rb

Multiplication and subtraction will record statistics in an eponymous .stats
file, that you can look at to review progress over time.

# Commentary

Addition followed a pattern where I gave 4 seconds to answer, but it turns out
that caused a few problems. (1) I relied on the timeout facilities in Ruby,
which always mess things up (in this case, occasionally corrupted input streams
from STDIN), and (2) it didn't give my son a chance to answer at times.

Subtraction and Multiplication keep a timer in the background, and let the user
answer, but won't count the answer correct unless the answer was provided in
the allotted time.
