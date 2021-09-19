************************
************************
*****SAS LESSON ONE*****
************************
************************;

***********
***INTRO***
***********
*Welcome to SAS! SAS is a statistical programming language that is extremely popular 
*because of its capability to handle large datasets. More detail on why to be provided
*later. For now, this lesson will go over the basics of SAS, including why we use SAS, 
*the library structure of SAS, and how to import your first dataset.;

*First things first: orientation. The following are the main components of the SAS window.;
*We'll discuss these in more detail in the following lessons:;

***.sas file window: where you write your SAS scripts;

***Log: the main SAS window that displays the commands (and SAS's reponse to them) as;
	*they're run. This is similar to the results section in Stata, or the command bar;
	*in R.;

***Output: displays output from commands. You will likely not use this window very often.;

***Explorer/Results;
****A. Explorer: shows libraries where you've created data objects. We'll discuss libraries;
		*very soon.;
****B. Results: displays output from commands like proc means in SAS 9.3 and above. You will;
		*also likely not use this window very often.;

***Command bar (bar in upper left of SAS window to the right of the checkmark): location 
	*to type things like "help datetime" if you want to know what the datetime command;
	*does;

*Now, SAS may look a bit confusing at first. As a first step to getting settled, exit all of;
*the windows except this one. That means to exit out of the "Output" window, the "Log";
*window, and the "Programming" window. These are the three windows that open by default when;
*you start SAS. Once you close those windows, mouse up to the "Window" ribbon above, and;
*click "Tile Vertically". This will make your programming window full screen and make it;
*easier to see everything.;

*Next, let's jump into basic syntax. SAS uses "*" to comment lines, or "/*" followed; 
*by "*/" to comment out a section. This is exactly the same as STATA syntax.;
*Another interesting thing: the end of a line is always indicated by a semi-colon.; 
*Therefore,
this is still part of the previous comment block,;
*but this is a new line of a comment block because of the semi-colon in the preceding line.;

*This implies that you only need one asterisk at the beginning of each multi-line comment
to comment everything. Extra asterisks are just superfluous, but it doesn't hurt to use them.;

*Another important starting point is the "library" structure of SAS. A SAS library
is simply a folder or location in which you can store data. All filenames within SAS
are specified by their library name and their actual name. Now, you may ask yourself
why SAS would have this library function. All other programs such as STATA, R Studio, and
Python Pandas just keep data in "memory" and you can access them from within the program.
The historical reason for this is that SAS is an old language, and when SAS was first
created in 1966, the average RAM on a computer was several kilobytes. Therefore,
one of the first problems that the early programmers had to solve was how to work
with big data, where "big" meant anything greater than a megabyte.;

*Thus, the library was born. With this structure, SAS doesn't keep anything in memory. 
SAS just runs commands over a dataset that is stored elsewhere at all times. While they 
may not have had any RAM back in the day, if you have data, you must be storing it somewhere,
so this allowed the early programmers to just run commands to change the data WITHOUT
actually having to worry about keeping data in memory.

*As programmers went along, they determined that it was in fact easier to keep data
in memory for a several reasons. These reasons included that it was easier to
analyze data if you could view it all at once rather than just chunks at at time. Additionally,
the library structure required SAS to save every intermediate version of the data, and
keeping data in memory avoided this and saved storage space overall. Finally, it's generally
faster to keep data in memory because you don't need to operate on data bit by bit.;

*Today, we have super computers that have terabytes of RAM. Between those computers 
and cloud computing, there is rarely (if ever) a need to run commands over a large 
dataset without importing it into memory. Large tech companies such as Google, 
Microsoft, and IBM likely have no need for SAS because they can handle data of virtually
any practical size in RAM. Nevertheless, the government does not have Google or Microsoft's
technical capabilities, so there is no way that we can keep really big datasets in
memory or use cloud computing to process big datasets.;

*So, long story short, SAS is the original "big data" tool. It has since been surpassed
by other programming languages and new technology, but since the government doesn't
have money for that technology, we need to use the "old reliable" big data tool to 
view or process large datasets.;


*********************
***GETTING STARTED***
*********************
*Moving on from our history lesson, recall that every file in SAS is referenced by
a library name and an actual name. This is always in the format "libraryname.filename" 
where the library name comes before the period. Most users put a library name (or multiple
library names) at the top of their SAS code, although you can put it anywhere. This is 
somewhat similar to setting a working directory, but you can think of the library as more 
of a temp folder in which SAS will save things, rather than a folder from which you can 
import.;

*The difference here is illustrated nicely by the following example. First, we set up the 
"practice" library. This can just be a folder on your desktop.;

*To set up your library, the syntax is "libname" (short for library name), followed by
the name of your library (in this case, "practice"), and finally, the file path of this
library:;
libname practice "[FILE PATH]\Desktop\SAS Practice";

*Now that your library is set up, clear your library. To do this, you will run the entire script
from the beginning up to this point. Highlight the entire script, then click the "running man"
in the bar at the top. 

The following command will delete all files in the practice library. We'll get more into
procedure steps later, but for now, this is the syntax for how to clear your library. This
is a datasets procedure, and you are deleting all objects in the "practice" library:;
proc datasets library = practice nolist kill; run; quit;

*Congrats! You just ran your first SAS command. Notably, if you just click the "running man"
at the top without highlighting anything, it will run the entire script. Additionally,
if you highlight anything, you can right click the highlight to "run selection" or press
F8 to run that code at any time.;

*Now, import a dataset from the training folder into your library. Here, we do the
simplest import: we import a csv file. This command will be in the format "proc import". 
"Proc" is short for "procedure", and all "proc steps" revolve around processing data. 
Examples of other proc steps include importing data, sorting data, and calculating 
averages of data. We'll discuss more about proc steps in the next lesson.;

*For now, let's dive into the syntax of the following import procedure. After "proc import",
The import command specifies the path of the datafile (the file that you're importing).
Following that, the "out" option specifies the name of the file that you're importing into 
SAS. Note that this is of the format "libname.filename" as we discussed above. Following
this, the command also uses the "dbms" option, which stands for "database management 
system" (or more practically, the filetype). This just needs to be set to the file extension
of the file you're importing. Finally, we use the replace option, which allows you to replace 
the file that you're using if there is already one of the same name in your library.
You might notice the placement of the semicolon in this statement as well at the end of the
specifications. This is followed by a "run" statement to indicate the end of the procedure
and its specifications.;

proc import datafile = "[FILE PATH]\SAS Training 2020\RawData\5-2016_QHP_Medical_Service_Pricing.csv"
	out = practice.deductibles
	dbms = csv
	replace;
run;

*Now, check the folder in which you set the "practice" library. You'll see your
imported dataset there as a SAS file! If you clear your library using the following
command, you'll see that this file will be deleted from the "practice" library folder:;
proc datasets library = practice nolist kill; run; quit;

*You can also see the contents of this folder by clicking on the "Libraries" icon in the
Explorer pane (off to the left), then clicking on the new icon entitled
"Practice". This shows the contents of your "practice" library. (It may be empty if you
just cleared your library.);

*Now that you understand the idea of a library, it is important to note that SAS's 
default library is the "work" library. This is a temporary library that is located in 
the temp folder on your C: drive. It is best practice to always specify your library,
but if you don't, then everything will be stored in your "work" library by default. 
Usually, you'll work out of the "work" library and just export to other folders, but it is
important to note that your "work" library will be cleared whenever you quit SAS. 
Therefore, any datasets or changes you make to data in the "work" library will be lost
when you quit your SAS session.;
