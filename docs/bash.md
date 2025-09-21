# Bash scripting

Based on the book _Pro Bash_ by J. Varma

## Basics

A shell script is a file containing one or commands that could be typed to the command line.

Bash scripts should have the following header.

```sh
#!/bin/bash
#: Title        : tmux-utils.sh
#: Date         : 2025-06-22
#: Authoer      : Edit Takacs
#: Version      : 1.0
#: Description  : Util function for tmux scripts
#: Options      : None
```

## Input, output, throughput

Parameter is an entity that stores values. There positional parameters, special parameters and variables. Positional parameters are arguments on the command line which are referenced by number. Special parameters are non-alphanumeric characters which store information about the shell's current state (e.g. number of arguments, exit code of the last command). Variables are identified by name.

`$*`, `$@` - the value of all positional arguments
`$#` - number of positional parameters
`$0` - path to the currently running script
`$$` - PID number of the current process
`$?` - the exit code of the last executed command
`$-` - option flag currently in effect

Variable are assigned by the `=` sign but there can be no white space between the variable name and it's value. Otherwise, it's interpreted as a condition test. Variables are usually uppercase.

It's better to use `printf` instead of `echo` if there escape characters in the string or the `-n` flag because the outcome might be system dependent.

`printf FORMAT ARG..`

```
printf "%s\n" print arguments on "separate lines"
printf "%b\n" "Hello\nWorld" "12\tword"
printf "%04d\n" 12 35 65
printf -v num "%04d" 4
```

Line continuation is done with backslash `\` so it ignores the new line character.

There are three streams attached to every commands and they are referred to by numbers: 1) stdin, 2) stdout, 3) stderr. I/O streams can be redirected to a file or into a pipeline.

The redirect operators are the arrows: `> >> <`
Redirecting standard output does not redirect the standard error, so error messages will still be displayed on the monitor.

The error messaged can be redirected to the _bit bucket_ aka `/dev/null`.

```
printf "%v\n" "Oops, wrong pattern" 2>/dev/null
```

The error can be redirected to the output stream.

```
printf "%v\n" "Oops, wrong pattern" 2>&1
```

Special syntax for redirecting standard output and error to the same file.

```
printf "%v\n" "Oops, wrong pattern" &> FILE
```

The `exec` command can be used to redirect the I/O streams for the rest of the script or until it is changed.

```
exec 1>tempfile
exec 2>errorfile
```

The `read` command is built-in command which reads from the standard input until a newline is received. The input is stored in one or more variables.

```
$ read a b c
jan feb march
$ echo $a
```

Command substitution is used when the output another process is saved in a variable to be used in the script later. Mind the space in the brackets. Also note, that command substitution should be reserved for external commands because with built-ins it tends to be very slow.

```
date=`date`
date=$( date )
```

## Looping and branching

The exit code is stored in `$?`, success is 0 and other int is an error code.

An expression can be tested with the `test` (also `[]`) built-in command, or by `[[]]` or `(())`. `test` compares strings, integers and file attributes, `[[]]` does the same thing but it can also handle regex, `(())` tests arithmetic expressions.

File tests:

```
test -e <file>  // exists
test -f <file>  // the type is file
test -d <ref>   // the type is dir
[ -x <file> ]   // executable
[[ -s <file> ]] // exists and executable
```

Integer tests:
`-eq, -ne, -gt, -lt, -ge, -le`

String tests:

```
test "$a" = "$b"    // other equality alternative is ==
[ "$q" != "$b" ]
[ -z "$a" ]         // empty string
[ -n "$a" ]         // non empty string
```

Like `test`, `[[...]]` executes an expression, but it's not a built-in command. Parameters are extended, but word splitting and file name extension are not performed with it.

Regex tests:

```
[[ $string =~ h[aeiou] ]]
```

The nonstandard feature, `(( arithmetic expression ))` returns false if the result is 0, otherwise 1. Since it's not a built-in command, but a syntax element, the expression is not parsed as other arguments. E.g. `<` are interpreted as smaller than and not as the redirection operator. Variables don't need the `$` sign. Non-numeric values are equivalent to 0.

```
if (( total > max)); then ...; fi;
```

## Conditional execution

Read and check input

```
read name
if [[ -z $name ]]
then
    echo "No name entered" >&2
    exit 1
fi
```

Prompt for a number and check if greater than 10

```
printf "Enter a number not greater than 10: "
read number
if (( number > 10 ))
    printf "%d is too big\n" "$number" >&2
    exit 1
else
    printf "You entered %d\n" "$number"
fi
```

Conditional operators: `&&` and `||` are evaluated left to right.

The `case` statement compares a word (usually a variable) against one or more patterns and executes the commands associated with that pattern. Patterns are path expansion patterns (with `*` and `?`), character lists, or ranges.

```
case WORD in
    PATTERN) COMMANDS ;;
    PATTERN) COMMANDS ;;
esac
```

Check the numbers of arguments is 3:

```
case $# in
    3) ;; # Nothing to do
    *) printf "%s\n" "Please provide 3 names" >&2
        exit 1
        ;;
esac
```

## Looping

A while loop:

```
n=1
while [ $n -le 10 ]
do
    echo "$n"
    n=$(( $n + 1 ))
done
```

Reading a file line by line:

```
while IFS= read -r line
do
    : do something with "$line"
done < FILENAME?
```

For loops takes a list of values, iterates over them and assigns them to a variable:

```
for var in Canada USA Mexico
do
    printf "%s\n" "$var"
done
```

Another for loop variant is the C-type syntax:

```
for (( n=1; n<=10; ++n ))
do
    echo "%n"
done
```

Exiting from a loop can be done with `break`.

```
while : # : is the equivalent of true
do
    read x
    [ -z "$x" ] && break
done
```

In order to break out of nested loops, `break` takes the number which represents the scopes.

```
for n in a b c d e
do
    while true
    do
        if [ $RANDOM -gt 2000 ]
        then
            printf .
            break 2     # break out of both loops
        elif [ $RANDOM -lt 10000 ]
        then
            printf '"'
            break       # break out of the inner loop
        fi
    done
done
echo
```

`continue` skips the rest of the inner logic and jumps to the next item in the iteration.

```
for n in {1..9}
do
    x=$RANDOM
    [ $x -le 1000 ] && continue
    echo "n=$n x=$x"
done
```

## Command-line parsing

When a line is executed, the shell splits the line into words wherever there is unquoted white space. The bash examines the resulting words and performs 8 type of expansions whenever it's applicable.

1. Brace expansion
   It operates on unquoted braces containing either a comma-separated list or sequence. Each element becomes a separate arguments. E.g. `{one,two,three}`, `{1..3}`, or `{a..c}`
   Multiple braces within the same word are expanded recursively.
   `{1..3}{a..c}` will become `1a 1b 1c 2a 2b 2c 3a 3b 3c`

2. Tilde expansion
   The unquoted tilde expands to the user's home directory `$HOME`.

3. Parameter and variable expansion
   Parameter expansion replaces a variable with its contents. The variable name should start with `$`. The variable can be enclosed in curly-braces `"${var}"`. The braces are optional, unless the position argument is greater than 9, or the next character could be interpreted as part of the variable name. Parameter expansions that are not enclosed in double quotes are subject to word splitting and pathname expansion.

4. Arithmetic expansion
   `$(( expression ))` is replaced by the result of the arithmetic expression. E.g.: `$(( 9-3 ))`

5. Command substitution
   Command substitution replaces a command with its output. The command must be either backticks ("`command`") or preceded by dollar sign i.e. `$( command)`

Count lines in a file which has the current date in its name.
`wc -l $( date +%Y-%m-%d ).log`

1. Word splitting
   The result of parameter and arithmetic expansion, and command substitution are subject to word splitting, if they are not quoted.
   Word splitting is based on the `IFS` variable. By default, it's defined as `IFS=' \t\n'`.

2. Pathname expansion
   Unquoted words containing `*`, `?`, and `[` are treated as file globing patterns and are replaced by alphabetic list of files that match the pattern. The asterisk matches any string. The question mark matches any single character. The square brackets match any of the enclosed characters (e.g. `[aeiou]`, `[[:lower:]]`)

3. Process substitution
   Process substitution creates a temporary file name for a command or list of commands. It can be used anywhere a file name is expected. The form is `<(command)` or `>(command)`.

## Parameters and variables

Variable names can contain only letters, numbers and the underscore. The name cannot start with a number. The convention is to use capital letters for environment variables, and local variables should be lower case. However, three are many uppercase variables defined by bash, that one can get in conflict with (e.g. `PATH`, `HOME`, `LINES`). So it's better to use lowercase variable names or prefix all uppercase variables with an underscore.
By default, variable definitions are only known to the shell in which it is defined, unless they are exported to the _environment_.
The environment is an array of strings of the form `name=value`. Whenever a command is executed (creating a child process), this array is passed along. In the script, these strings are available as variables.
Variables in a script can be added to environment with the `export` build-in command.

```
export var=whatever
```

Once a variable is exported, it remains in the environment until it is unset.

Variables can have default values if they are unset or empty. In the below example, it check if `var` is set, and if it's not or empty, it expands it to the string `default`.

```
"${var:-default}"
```

A default value can be added to a variable this way:

```
defaultfile=$HOME/.bashrc
## parse options
filename=${filename:-"$defaultfile"}
```

Another way to do is with `"${var:=default}"`. It also assigns the default value to the variable in one go.

Adding string to a variable:

```
var=something
var="$var else"
```

Check the length of a variable: `${#passwd}`

Remove the shortest match from the end:

```
var=Wallongong
printf "%s\n" "${var%o*}"
# Wallong
```

Remove the longest match from the end:

```
var=Wallongong
printf "%s\n" "${var%%o*}"
# Wall
```

Remove the shortest match from the beginning: `"${var#o*}`
Remove the longest match from the beginning: `"${var##o*}`

Replace all characters:

```
var=abcd
printf "%s\n" "${var//?/*}"
# ****
```

With the single slash at the beginning only the first match is replaced: `printf "%s\n" "${var/?/*}"`

Return a substring of a variable: `${var:OFFSET:LENGTH}` (`"${var:3:4}"`). The length part is optional and with negative offset, the substring is taken from the back.

Convert to uppercase:

```
val=melburne
printf "%s\n" "${var^}"
# Melburne
printf "%s\n" "${var^[a-z]}"
# Melburne
printf "%s\n" "${var^^[a-l]}"
# meLBurnE
printf "%s\n" "${var^^}"
# MELBURNE
```

Convert to lowercase:

```
val=MELBURNE
printf "%s\n" "${var,}"
# mELBURNE
printf "%s\n" "${var,,}"
# melburne
```

### Positional Parameters

Positional parameters can be referenced by numbers (`$1...$9 ${10}`). All arguments can be accessed by `$@` or `$*`. Parameters which are greater than 9 need to enclosed in curly braces. The `shift` command without an argument removes the first positional parameter and shifts the remaining arguments forward. With an argument, `shift` can remove more.

Looping over the parameters:

```
for param in "$@"
do
    echo $param
done
```

With a while loop:

```
while (( $# ))
do
    echo "$1"
    shift
done
```

### Arrays

Arrays are one dimensional data structures which are indexed by integers, or in later versions by strings. The indexing is zero based and denoted by `[]`.
All the elements of an array can be printed with `[*]` or `[@]`. The difference between the two is that when `[*]` is quoted in double-quotes the arguments are expanded to a single argument, but `[@]` is split up to separate arguments (bash-words) even when it's quoted.

Assigning array elements:

```
name[0]=Aaron
name[42]=Adams
```

Note that indexes do not need to be consecutive, but they are more useful that way.
Assign value to the next unassigned index:

```
unset a
a[${#a[@]}]="1 $RANDOM"
a[${#a[@]}]="2 $RANDOM"
printf "%s\n" "${a[@]}"
```

Assigning values to an array:

```
states=( TAS QLD VIC )
states+=( NSW )
states+=( ACT "WA" "NT" )
```

Associative arrays use strings to subscript elements. They need to be declared before used:

```
declare -A array
for subscript in a b c d e
do
    array[$subscript]="$subscript $RANDOM"
done

printf ":%s:\n" "${array[@]}"
```

## Shell functions

There are three ways to define functions:

```
function name { <compound command> }

name() { <compound command> }

function name() { <compound command> }
```

Functions are executed in the same context as the calling context. No subprocess is created. The calling program only knows whether the function was successful or not, based on the exit status code. Functions can also return information from a range of return codes by setting variables or by printing its results. Return codes are a single, unsigned byte, so it ranges between 0 and 255.

Example of program which prints to a file or to the standard output (`/dev/fd/1`) if no file is specified.

```
uinfo() #@ USAGE: uinfo [file]
{
    printf "%12s: %s\n" \
        USER "${USER:-No value assigned}" \
        PWD "${PWD:-No value assigned}" \
        HOME "${HOME:-No value assigned}"
} > ${1:-/dev/fd/1}
```

When the output is printed to the standard output, it can be captured using command substitution. The only downside is that command substitution creates a new subprocess and due to that it can be slow. To get around this limitation, setting variables in a function is often used in bash scripts.

```
info=$( uinfo )
```

In newer versions of bash, the variable name can even passed to store the result it. For example, in this script the 4th positional arguments can be used as the name of the resulting array, otherwise it's set to the default `_MAX3` is used.

```
#@ Sort 3 integers and store in an array
#@ USAGE: max3 N1 N2 N3 [VARNAME]
max3() {
    declare -n _max3=${4:-_MAX3}
    (( $# < 3 )) && return 4
    (( $1 > $2 )) && set -- "$2 $1 $3"
    (( $2 > $3 )) && set -- "$1 $3 $2"
    (( $1 > $2 )) && set -- "$2 $1 $3"
    _max3=( $3 $2 $1 )
}
```

## String manipulation

### Concatenation

Strings can be joined by putting them next to each other (e.g. `PATH=$PATH:$HOME/bin`). After bash 3.1, strings can be appended to string variables by the `+=` operator.

### Case conversion

```
echo abcdefg | tr ceh CEH
echo touchdown | tr 'a-z' 'A-Z'

var="hello, world"
echo "${var^^}"
```

### Comparing content

Accepting lower and upper case character from the user:

```
read ok
case $ok in
    y|Y) echo "Great!" ;;
    n|N) echo "Good-bye"
        exit 1
        ;;
    *) echo "Invalid entry" ;;
esac
```

The possible values can also be provided in square bracket options:

```
read monthname
case $monthname in
    [jJ][aA][nN]*) month=1 ;;
    [fF][eE][bB]*) month=2 ;;
    ...
    [dD][eE][cC]*) month=12 ;;
    [1-9]|1[0-2]) month=$monthname ;;
    *) echo "Invalid month: $monthname" >&2 ;;
esac
```

A valid variable name in bash should only contain letters, digits and the underscore, and cannot start with a digit:

```
validname() #@ USAGE: validname varname
{
    case $1 in
        [!a-zA-Z_]* | *[a-zA-Z0-9_]*) return 1 ;;
    esac
}
```

### Insert one string into another

```
_insert_string() #@ USAGE: _insert_string STRING INSERTION [POSITION]
{
    local insert_default_pos=2
    local string=$1
    local i_string=$2
    local i_pos=${3:-${insert_default_pos}}
    local left right
    left=${string:0:$(( $i_pos - 1 ))}
    right=${string:$(( $i_pos - 1 ))}
    _insert_string_res=$left$i_string$right
}

insert_string()
{
    _insert_string "$@" && printf "%s\n" "$_insert_string_res"
}
```

### Replace parts of a string with another string

```
_overlay() #@ USAGE: _overlay STRING SUBSTRING START
{
    local string=$1
    local sub=$2
    local start=$3
    local left right
    left=${string:0:start-1}
    right=${string:start+${#sub}-1}
    _overlay_res=$left$sub$right
}
overlay()
{
    _overlay "$@" && printf "$s\n" "$_overlay_res"
}
```

### Trim white spaces

```
var="  John   "
while :
do
    case $var in
        ' '*) var=${var#?} ;;
        *' ') var=${var%?} ;;
        *) break ;;
    esac
done
```

Another approach would be to search for the longest spaces at the beginning and at end of the string and remove them.

```
var="  John   "
rightspaces=${var##*[! ]}
var=${var%"$rightspaces"}
leftsapces=${var%%[! ]*}
var=${var#"$leftspaces"}
```

## File operations and commands

### Reading in a file's content

Given the phone file contains these entries:

```
John:555-1234
Jane:555-5678
```

One can read the content line by line and parse the lines like this:

```
while IFS=: read name phone
do
    printf "Name: %-10s\tPhone: %s\n" "$name" "$phone"
done < "$file"
```

Placing the `IFS` assignment in front of the command causes it to be local to that command and does not change its value elsewhere in the script.

### External commands

External command which can also be used to read the content of a file are:

#### `cat`

Reads all the files on its command line and prints their content to stdout.

#### `head`

Prints the first 10 lines of each file in its input

#### `touch`

Update the time stamp of a file, creates an empty file if it does not exist.

#### `ls`

List files, equivalent to file expansion and white spaces in file names can cause unexpected results.

#### `cut`

Extract positions of a line by character or field.

```
cut -c 22 $file | head -n3
cut -c 22,24,26 $file | head -n3
cut -c 22-26 $file | head -n3
cut -c -26 $file | head -n3
```

```
# print the third item in the list
boys="Brian,Carl,Dennis,Mike"
printf "%s\n" "$boys" | cut -d, -f3

IFS=,
boyarray=( $boys )
printf "%s\n" "${boyarray[2]}"

temp=${boys#*,*,}
printf "%s\n" "${temp%%,*}"
```

#### `wc`

Count the number of lines, words, and bytes in a file.

#### `grep`

Searches file on the command line, support regular expressions.

#### `sed`

Replace a string or pattern with the stream editor, also support range.

## Commands

pwd - prints the name of the current directory
cd - change working directory
echo - prints its arguments separated by spaces and terminated by a new line
type - display information about the command
chmod - change the file permissions
source - aka `.` executes a script in the current shell environment
printf - print the arguments as specified by the format string
cat - print the content of one or more files to the standard output
tee - copies the standard input to the standard output and file(s)
read - built-in command which reads a line from the standard input
date - print current date and time
test - evaluates an expression and returns success or failure
if - executes if command is successful
case - matches word against one or more pattern
while/until/for - loop keywords
break/continue - control keywords
head - extract the firs n lines from a file
cut - extract columns from a file
declare - declares variables and sets their attributes
eval - expands arguments and executes the resulting command
export - places variables into the environment so they are available to the child process
shift - deletes and renumbers positional parameters
shopt - sets shell options
unset - removes a variable entirely
local - restrict variable scope to he current function and its children
return - exit a function
set - with -- replaces the positional parameters with the remaining arguments
tr - translate characters

## Variables

PWD - pathname of the shell's current working directory
HOME - path to the user's home directory
PATH - a colon-separated list directories in which command files are stored

$$
$$
