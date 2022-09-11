The Sorter 1.0
Copyright © 2000

Kory Roberts
http://www.k2w.f2s.com/
kaptainkory@yahoo.com

Please turn on WORD-WRAP.

Although I don't think this movie is terribly difficult to figure out, let me first say that you can copy the functions from Frame 1 into your projects and immediately use them.  The whole purpose of this little movie is to show the possibilities of the sorting function.

If you are familiar with Flash 5 ActionScripting, you know that there is an Array.sort() function.  While this may be adequate for some, it leaves a lot to be desired.  For starters, it sorts all uppercase letters before lowercase letters.  Most people probably wouldn't find this an adequate sort for their data:  "A, B, C, a, b, c".

Now let's take a look at the power of the sorter() function:

sorter (the_data, delimiter, reverse, uppercase_first, articles, after_match, match_times)

The variables in parentheses are called arguments.  This function will accept from 1 to 7 arguments.  Let's assume we have a TextField named "data_out" and a string of data named "data_in":

data_out = sorter (data_in);

This is perfectly adequate for a simple sort.  Unlike Flash 5's Array.sort(), the sorter() function would return a string that might look like this:

a
A
b
B
c
C

Now let's assume that data_in = "c:b:a:A:C:B".  In this case, we'd want to specify a delimiter, and perhaps reverse the order, or maybe even sort with uppercase before lowercase.

data_out = sorter (data_in, ":");  // Returns "a:A:b:B:c:C".
data_out = sorter (data_in, ":", true);  // Returns "C:c:B:b:A:a".
data_out = sorter (data_in, ":", false, true);  // Returns "A:a:B:b:C:c".

The next argument, articles, tells whether or not we'd like to handle articles...You know, "a", "an" and "the". Let's assume data_in =

The Adventures of Tom Sawyer
To Kill a Mockingbird
A Tale of Two Cities

data_out = sorter (data_in, newline, false, false, true);  // Returns 

Adventures of Tom Sawyer, The
Tale of Two Cities, A
To Kill a Mockingbird

The next arguments, after_match and match_times, work together (though match_times defaults to 1 if not included as an argument along with after_match). Now let's assume data_in =

<a href="http://www.untilhello.com">Until Hello</a>
<a href="http://www.k2w.f2s.com/shirt_storys/">Shirt Storys</a>
<a href="http://www.k2w.f2s.com/software/">ScoreKeeper</a>
<a href="http://www.k2w.f2s.com">Kaptain Kory's World</a>

data_out = sorter (data_in, newline, false, false, false, '>');  // Returns

<a href="http://www.k2w.f2s.com">Kaptain Kory's World</a>
<a href="http://www.k2w.f2s.com/software/">ScoreKeeper</a>
<a href="http://www.k2w.f2s.com/shirt_storys/">Shirt Storys</a>
<a href="http://www.untilhello.com">Until Hello</a>

Now let's include the argument, match_times, which tells what part of the string to consider for sorting.

data_out = sorter (data_in, newline, false, false, false, ' ', 2);  // Sorts according to the second whitespace and returns

<a href="http://www.untilhello.com">Until Hello</a>
<a href="http://www.k2w.f2s.com">Kaptain Kory's World</a>
<a href="http://www.k2w.f2s.com/shirt_storys/">Shirt Storys</a>
<a href="http://www.k2w.f2s.com/software/">ScoreKeeper</a>

Since that last link doesn't have 2 whitespaces, it is sorted after all of the ones that DO include 2 whitespaces.

Unfortunately, we CANNOT do something like this:

data_out = sorter (data_in, , , , , '>');

We will simply have to fill in all of the default values up to the argument we wish to adjust.  Here is the function using all DEFAULT VALUES:

sorter ([array or string], newline, false, false, false, '', 1);

I believe the looping limit in Flash is 200,000 before a warning is given.  While I find it unlikely you would run into this problem, it is theoretically possible you could reach this limit while sorting with this function.  Still, the sorting routines I use require far fewer iterations than would the equivalent Flash 4 coding.

I hope you have found this sorting function, movie, and readme to be helpful.  Please drop me an email to report any bugs, or just to say, or even how you are using this function in your own projects!

kaptainkory@yahoo.com

Cheers!
Kory