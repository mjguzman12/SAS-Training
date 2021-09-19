**************************
**************************
*****SAS LESSON THREE*****
**************************
**************************;

*This lesson discusses manipulating data in SAS, including creating vars, 
deleting vars, and keeping observations based on other characteristics. We also 
introduce proc sort and proc means.;


************
***HEADER***
************
*Let's start this lesson with a standard SAS header;
options nocenter ls = 175 ps = 66 obs = MAX compress = yes nofmterr;
libname repo "[FILE PATH]\repo";
filename home "[FILE PATH]\SAS Training 2020\RawData";
filename inter "[FILE PATH]\SAS Training 2020\IntermediateData";
filename out "[FILE PATH]\SAS Training 2020\Output";
%let raw = %sysfunc(pathname(home));
%let intermed = %sysfunc(pathname(inter));
%let output = %sysfunc(pathname(out));
proc datasets library = work nolist kill; run; quit;

*The above may appear to be quite a long header, but let's break it down. Most SAS
scripts start with the "options" statement. We already saw this in Lesson 2 when
we looked at "options obs = MAX". In fact, you can specify multiple options in a
single options statement. The ones listed above are pretty standard and it's unlikely
that you'll need to adjust them, but here is the breakdown of what they mean:

***nocenter: by default, SAS centers your output and your output text. We haven't
	discussed output files just yet, but it is typically easier to read them as a
	left-justified file

***ls: short for "linesize". This specifies the maximum number of characters in a line
	in SAS. This doesn't impact how SAS reads code, it only impacts how it displays lines
	in the log file.

***ps: short for "pagesize". This specifies the number of lines on a page in SAS. Being an
	older language, SAS is designed such that you can literally print your code, so
	this setting is particularly useful if you need to print anything.

***obs: we've seen this before. Short for "number of observations". You almost always want
	to set this to MAX in the first line of your script. You can change it to a smaller
	number of observations later, but always set it to MAX in the beginning to be on
	the safe side.

***compress: specifies whether SAS datasets are compressed or not. Technically, this is
	the difference between allowing for fixed and variable length observations within
	the same field. This specification makes things take longer, but you should ALWAYS
	use it anyway to save space on your machine (especially if you share that machine
	with other people.)

***nofmterr: This is the opposite of the fmterr specification, which is short for "Format 
	Missing, Then Error". The reason for this specification is twofold. The first is that
	when SAS encounters a missing value when importing a dataset, it will not know how to
	format it. The default step after this is to error out and stop importing. Oftentimes,
	we have datasets in which missing values are perfectly fine, and this specification tells
	SAS that we can ignore them. (Get it? NO "Format Missing, Then Error"). Additionally,
	you may accidentally write a format in your data step that doesn't exist due to typos. 
	This will make sure that SAS will use a default format in that case as well.

*Moving on to the other parts of our header, we set up a new library entitled repo (short
for "repository"). This is totally optional, and you can call it whatever you want.
Sometimes, it is useful to have a separate library from your "work" library to store things,
as files won't disappear from that folder. This is totally personal preference though.

*As you may have intuited, the next four specifications are simply file paths, and then
we use the "let" and "sysfunc" macro commands to set the file path shortcuts to our
directory. Once again, totally optional - this just makes it easier to reference files.

*Finally, we end the header with the command to clear the "work" library. This is also
optional as you may not want to clear your work library in every script, but it is
useful.;


***********************
***MANIPULATING DATA***
***********************;
/*KEEPING AND DROPPING OBSERVATIONS*/
*Now that we have that out of the way, let's learn how to manipulate data in SAS!
While it is possible to use proc steps to manipulate data, most of what you'll
use to create and delete variables will be through data steps. This makes sense
because it would be pretty difficult for programmers to anticipate the
cleaning commands that you'll need.

*Let's start by importing our bikeshare example dataset from Lesson 2:;
proc import datafile = "&raw\Capital_Bike_Share_Locations.csv"
	out = work.bike_locations
	dbms = csv
	replace;
	getnames = yes;
	delimiter = ",";
run;

*Note that we just used "&raw" in the beginning of the filepath to use the raw
filepath that we set up in the header.;

*Let's use a datastep to keep observations if the number of bikes at a station is
greater than 10.;
data work.bike_locations_10;
	set work.bike_locations;
	if NUMBER_OF_BIKES > 10 then output;
run;

*Breaking this down, the first line, creates a dataset entitled bike_locations_10. 
This goes back to SAS's old quirks. Every step must create a new dataset, because 
we never have any data in memory. The second line sets the work.bike_locations dataset
as our base. SAS will start with that to create work.bike_locations_10, and our datastep
can make additional changes to that data.

*The next line is an if statement. It says that SAS should output observations to the
new datasets if the NUMBER_OF_BIKES variable is greater than 10. Usually, we don't write the 
"then output" part of this statement, so a more typical version of this datastep would look
like this:;
data work.bike_locations_10;
	set work.bike_locations;
	if NUMBER_OF_BIKES > 10;
run;

*SAS will fill in the "then output" part.;

*The opposite of keeping observations is dropping observations. For this, the command
will be almost the same, but you do need the second half of the if statement to instruct
SAS not to keep observations:;
data work.bike_locations_10;
	set work.bike_locations;
	if NUMBER_OF_BIKES <= 10 then delete;
run;

*Additionally, SAS doesn't use a different expression to evaluate booleans, so if you just
wanted locations in which the number of bikes were exactly 10, the expression would be:;
data work.bike_locations_10;
	set work.bike_locations;
	if NUMBER_OF_BIKES = 10;
run;

*What if you just wanted locations in which the number of bikes were NOT exactly 10?
Unlike virtually every other programming language, SAS does not use "!=" for not equal
to. SAS uses "~=" for not equal to, so data step would be:;
data work.bike_locations_not_10;
	set work.bike_locations;
	if NUMBER_OF_BIKES ~= 10;
run;

*Finally, what if you want to string together multiple boolean expressions to keep
observations if the the number of bikes is BETWEEN 7 and 12? We could use the "and"
syntax to accomplish this:;
data work.bike_locations_bet_7_12;
	set work.bike_locations;
	if NUMBER_OF_BIKES > 7 and NUMBER_OF_BIKES < 12;
run;

*You could equivalently string booleans together with an "or" statement. How intuitive
is that?;
data work.bike_locations_l7_g12;
	set work.bike_locations;
	if NUMBER_OF_BIKES < 7 or NUMBER_OF_BIKES > 12;
run;


/*KEEPING AND DROPPING VARIABLES*/
*Another thing we might want to do is drop the INSTALLED and LOCKED variables. Here,
we could use the drop statement in a datastep:;
data work.bike_locations_varsdropped;
	set work.bike_locations;
	drop INSTALLED LOCKED;
run;

*This syntax is very similar to Stata. Additionally, a nifty thing to note is that SAS
doesn't care about upper or lower case characters in most instances. So, we can rewrite
the command above as:;
data work.bike_locations_varsdropped;
	set work.bike_locations;
	drop installed locked;
run;

*Or:;
DATA WORK.BIKE_LOCATIONS_VARSDROPPED;
	SET WORK.BIKE_LOCATIONS;
	DROP installed locked;
RUN;

*We could also do the reverse of this to just keep the latitude and longitude variables:;
data work.bike_locations_varskept;
	set work.bike_locations;
	keep latitude longitude;
run;

*Another common thing that you may want to do is create variables. SAS has syntax most
similar to R in this respect. If you try to assign a variable in a datastep, then SAS
will first check if the variable name is already present in the "set" dataset. If there is 
a variable of that name in the dataset already, then SAS will reassign the variable in the 
dataset to the new value. If the variable is not present in the dataset, then SAS will create
a new variable with that name.;

*Say we just wanted to create a test variable of 1s in the bike locations dataset. We
could do so with the following syntax:;
data work.bike_locations_test;
	set work.bike_locations;
	test = 1;
run;

*If you check, there is now a test variable at the end of the dataset that is equal to 1
for all observations. If we do the same thing with a variable entitled latitude, we just
replace the latitude variable with 1s.;

data work.bike_locations_test;
	set work.bike_locations;
	latitude = 1;
run;

*The one other common thing that you might need to know is how to change the variable
type from string to numeric, or back. SAS is a bit finicky about this. Basically,
you can't reassign a numeric variable or a string format, or vice-versa. That means
that you always need to create a numeric or string variable with a new name, then drop
the original var, then rename the new var. Let's review these steps below:;

*To illustrate this, let's try to convert the ID variable to a string. The function
to convert numerics to strings is the "put" variable, and the second argument is the
format:;
data work.bike_locations_stringtest;
	set work.bike_locations;
	latitude = put(latitude, 2.);
run;

*If you check the dataset, you will notice that the latitude variable, while now 2 bytes,
is still right justified as a numeric. I.E. changing the variable type using the put command
above didn't work. The complete way to change a variable type would be to create a new variable
as we do below entitled "latitude_stringtest":;
data work.bike_locations_stringtest;
	set work.bike_locations;
	latitude_stringtest = put(latitude, 2.);
run;

*To emphasize the point above, you cannot simply "destring" a variable as you might be
accustomed to doing in STATA or R Studio. You need to generate a new variable with a
different name anytime you try to "destring" a variable.

*Now, there will be a new "latitude_stringtest" variable at the end of the dataset,
and we can subset using it with the following command:;
data work.bike_locations_stringtest;
	set work.bike_locations_stringtest;
	if latitude_stringtest = "39";
run;

*The opposite of converting numerics to strings is converting strings to numerics.
We do this in virtually the same way, but with the "input" function:;
data work.bike_locations_stringtest;
	set work.bike_locations_stringtest;
	latitude_numerictest = input(latitude_stringtest, 2.);
run;

*Note in our set statements above, we changed the input dataset to the 
"work.bike_locations_stringtest" dataset. Why is this important? This illustrates
the possiblity that you can create a new dataset in one step (as we did when we created
the "latitude_stringtest" variable), and THEN we can can edit that new dataset. This keeps
our original dataset intact. Therefore, we can use a "working dataset" wich we can
manipulate and edit all without changing the source dataset.;

*Now, we've covered keeping and dropping observations, creating and dropping variables,
and changing the type of variables from numeric to string and back. It may have seemed
a bit tedious to set up a datastep for every part of this, and you're absolutely right.
As SAS is always just running commands over data, you can in fact run many commands over
a dataset at once. In this way, we can combine all of the commands that we have written
thus far into the following datastep:;
data work.bike_locations_final;
	set work.bike_locations;
	test = 1;
	latitude_string_test = put(latitude, 2.);
	if number_of_bikes > 10;
	drop installed locked;
run;

*In most cases, you want to minimze the number of steps that you need to run.
Particularly with large datasets, you want to run commands over datasets as few
times as possible. This is also a good lesson that you can simplify your code greatly
in SAS by combining many commands into a single step.;


******************************
***PROC SORT AND PROC MEANS***
******************************;
*Now, if you're working in SAS, odds are that you're working with big data. Therefore,
now that you know how to import your big data and do basic manipulations, the next 
thing you'll probably want to do is aggregate your data. This is typically accomplished
by using the sort procedure and the means procedure.;

*A brief note on proc sort and proc means. These two procedures are incredibly
versatile commands, however, you will typically not be able to break them down
into data steps in the same way in which we broke down proc import. Now, you may
be thinking that this is quite odd considering that proc steps are built on top
of data steps. This is true, however, SAS specifically does not allow you to see the
behind-the-scenes code for sorting. This is because sort algorithms are extremely
expensive and complex. They rely on significant computing power to break data into
many parts, sort each part individually, and put the data back together in sort
order. As these algorithms are so expensive, the programming behind these commands
is a trade secret. While it is theoretically possible to write your own sort command
in a data step, it would be prohibitively complex and it is not recommended.
Collapsing data and merging data both rely on sorting, so you would have a very hard
time doing these or other SAS functions built on sorting in a data step. Fortunately,
proc sort and proc means are both very powerful and straightforward, and you should
have no problem using them to solve your problem.;

*Regarding the practical use of proc sort, the syntax is slightly different from
a data step. Like proc import, you have the data specification, which is the dataset
that you are using as a base, and an "out" dataset, which is the dataset that you
are creating. Following this, you have the "by" statement, which indicates by which
variables you are sorting.;
proc sort data = work.bike_locations out = work.bike_locations_sorted;
	by number_of_bikes;
run;

*You can also sort by multiple variables:;
proc sort data = work.bike_locations out = work.bike_locations_sorted;
	by number_of_bikes id;
run;

*And you can also sort in descending order. Note that the descending specification
only applies to the very next variable listed.;
proc sort data = work.bike_locations out = work.bike_locations_sorted;
	by descending number_of_bikes id;
run;

*One other thing to note is the location of the semi-colons in the command. The data
and out statements are in the same line, and the by statement is in the next line.;

*Moving on to proc means, there are a few more important specifications than proc sort.
Here, as with proc sort, you need the "data" specification and the "out" specification.
Notably however, proc means won't just collapse. It gives you every summary statistic you
could want for a particular variable. Check the output of the following command. Note that
we have not specified anything other than the data, the variable on which we're collapsing,
and the output.;
proc means data = work.bike_locations;
	var number_of_bikes;
	output out = work.bike_locations_collapsed;
run;

*That command should have brought up a separate output table with the number of observations
(N), the mean, the standard deviation, the min, and the max. This is SAS's default to
create a simple table that you could quickly copy and paste into a document or print
to paper.;

*This is likely not something that will be particularly useful to you. Oftentimes,
you will want to collapse by specific variables, and you will want a collapsed
dataset, not a summary table. To get there, you should use the "class" statement
and the "noprint" option:;
proc means data = work.bike_locations noprint;
	class terminal_number;
	var number_of_bikes;
	output out = work.bike_locations_collapsed;
run;

*The "noprint" options just stops SAS from showing the summary table. The class statement 
is really like a "by" command in Stata. SAS will now collapse and provide summary 
statistics for number of bikes by terminal number. Notably, SAS will compute summary 
statistics for every combination of class variables. For example, if you try to collapse 
the work.bike_locations dataset on terminal number and owner, you will get a dataset 
with collapsed information for every combination of terminal_number and owner, which 
implies all of the collapsed data by owner, all of the collapsed data by terminal_number, 
AND all of the collapsed data by terminal_number and owner.;
proc means data = work.bike_locations noprint;
	class terminal_number owner;
	var number_of_bikes;
	output out = work.bike_locations_collapsed;
run;

*Typically, you will not want every combination of collapsed variables, so you need
to use the "nway" specification to suppress this:;
proc means data = work.bike_locations nway noprint;
	class terminal_number owner;
	var number_of_bikes;
	output out = work.bike_locations_collapsed;
run;

*Additionally, you will also typically want to use the "missing" specification to make sure
that SAS doesn't exclude observations that are missing from the calculation. Better
practice would be to drop the missing values prior to collapsing.;
proc means data = work.bike_locations nway noprint missing;
	class terminal_number owner;
	var number_of_bikes;
	output out = work.bike_locations_collapsed;
run;

*Finally, you will likely want to know how to collapse data taking a sum or other
summary statistic. This is fully controlled by the output statement. Here, you can
specify the type of stat you want, as well as the name of the new collapsed variable
if you like:;
proc means data = work.bike_locations nway noprint missing;
	class terminal_number owner;
	var number_of_bikes;
	output out = work.bike_locations_collapsed sum = sum_number_of_bikes;
run;

*If you don't specify a name and leave the space after the stat blank, the name will
simply be the original name of the variable:;
proc means data = work.bike_locations nway noprint missing;
	class terminal_number owner;
	var number_of_bikes;
	output out = work.bike_locations_collapsed sum = ;
run;

*Don't forget to clear your work library before you go on to Lesson 4!;
