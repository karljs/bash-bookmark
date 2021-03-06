# Bash Bookmarks

This is a bash script designed to help you manage moving between unwieldy
directories.  Sometimes `pushd` doesn't cut it, and aliases are tedious and
awkward.

In order for this to work as expected, you need to create an alias that calls
the `bookmark.sh` script in your current shell.  This is because simply running
it will cause the directory change to happen in a subshell instead of your
current one.  See the installation instructions below for tips.

## Warning
This is unpolished software.  You are likely to encounter bugs.  Reports and
patches are appreciated.

## Installation
First, place this script somewhere on your $PATH.

Now open your Bash configuration file (`~/.bashrc` on Linux, `~/.profile` on OS
X) and add the following (note the first dot character):

`alias cdb='. bookmark.sh'`

You can replace `cdb` with another name if you prefer.

## Usage
Once you have your alias set up, you can add new bookmarks as follows:

`cdb -c name` 

This will add your current working directory to the database of bookmarks using
the provided name.  It can be used to overwrite existing bookmarks, too.

After adding a bookmark, you can change to that directory as follows:

`cdb name`

Finally, you can remove a bookmark with the `-d` flag:

`cdb -d name`


