noodle
======

On 12/13/13, thoughtbotters took a break from client work and paused for 
play.

What started as a rudimentary zsh history analysis tool quickly became a 
kata, to be implemented in many languages so as to compare them.

As a history analyzer, it's fairly useless. But as an excuse to play 
with new languages, it's just right.

Feel free to noodle around.

## The Task

* Accept lines of shell history on `stdin`.

* Output the top *N* most costly lines where *N* is passed on the 
  command-line and defaults to 10.

* Cost is determined as command name length times number of occurrences.

For example, you may call `ls` three times and `rake` twice. In this 
case, `rake` is more costly (4 * 2 = 8) even though it's called fewer 
times than `ls` (2 * 3 = 6).

## To Test an Implementation

```
$ diff ./files/expected.txt <(run-your-program < ./files/history.txt)
```
