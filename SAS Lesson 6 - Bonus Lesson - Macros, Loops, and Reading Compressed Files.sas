**************************
**************************
*****SAS BONUS LESSON*****
**************************
**************************;

options nocenter ls = 175 ps = 66 obs = MAX compress = yes nofmterr;
libname repo "[FILE PATH]\repo";
filename home "[FILE PATH]\SAS Training 2020\RawData";
filename inter "[FILE PATH]\SAS Training 2020\IntermediateData";
filename out "[FILE PATH]\SAS Training 2020\Output";
%let raw = %sysfunc(pathname(home));
%let intermed = %sysfunc(pathname(inter));
%let output = %sysfunc(pathname(out));
proc datasets library = work nolist kill; run; quit;


***********
***INTRO***
***********;
*Welcome to the SAS Bonus Lesson! This lesson discusses SAS macros and how to read
compressed files. As you may recall if you are doing these lessons in order, we
explicitly warned against using macros in Lesson 2. SAS macros should really be
thought of as sudo programming. They are very similar to STATA programs, and somewhat
similar to R functions. Macros are notably different from regular SAS programming
because they can take multiple inputs. Additionally, they can do different things
based on if else statements, and thus you can write more complex programs here.;


****************
***SAS MACROS***
****************;
*For the typical data analyst, SAS macros will typically be the most useful when you
need to perform a repetetive task. The structure of a SAS macro is simply a preset of 
code that you write. You can write data or proc steps into a macro, and then you can
automate the inputs so that you don't need to rewrite code. This is very useful if you have something that you want to do
multiple times, such as reading in files or editing multiple files in a particular way.;

*Note: this code is taken liberally from Ari Gerstle's training script.;

*DEFINE MACRO LOOP **;
*The syntax to define a macro is:				**;
*  %macro  macroname(<macro var 1>, <macro var 2>,....)	**;
*	%macro  -- SAS command to start defining the macro	**;
*	macroname -- user defined name for this loop of commands**;
*	macro var # -- list of macro variables whose values are **;
*		       assigned later when the command to invoke**;
*		       the macro is given. As seen below, 	**;
*		       an invocation of the macro will take the **;
*		       form %macroname(<macro var 1 value>, <macro var 2 value>,...) **;

%macro grad_import(fnm,fref);

*DATA STEP TO INFILE THE RAW DATA
*NOTE: in the data statement, the program names a file WORK.&fnm

***WORK is simply the SAS working dirctory.
***&fnm is the first macro variable. Each time the macro loop
***executes, SAS will use the supplied value for this variable.;
data work.&fnm;
	retain
		stnam
		fipst
		leaid
		st_leaid
		leanm
		ncessch
		st_schid
		schnam
		all_cohort_1718
		all_rate_1718
		mam_cohort_1718
		mam_rate_1718
		mas_cohort_1718
		mas_rate_1718
		mbl_cohort_1718
		mbl_rate_1718
		mhi_cohort_1718
		mhi_rate_1718
		mtr_cohort_1718
		mtr_rate_1718
		mwh_cohort_1718
		mwh_rate_1718
		cwd_cohort_1718
		cwd_rate_1718
		ecd_cohort_1718
		ecd_rate_1718
		fcs_cohort_1718
		fcs_rate_1718
		hom_cohort_1718
		hom_rate_1718
		lep_cohort_1718
		lep_rate_1718
		date_cur
		;

%let _EFIERR_ = 0; * set the ERROR detection macro variable *;

infile &fref delimiter = "," missover dsd termstr = crlf length = reclen firstobs = 2;

		informat stnam 						:$30.;
		informat fipst 						:$30.;
		informat leaid 						:$30.;
		informat st_leaid 					:$30.;
		informat leanm 						:$30.;
		informat ncessch 					:$30.;
		informat st_schid 					:$30.;
		informat schnam 					:$30.;
		informat all_cohort_1718 			:$30.;
		informat all_rate_1718 				:$30.;
		informat mam_cohort_1718 			:$30.;
		informat mam_rate_1718 				:$30.;
		informat mas_cohort_1718 			:$30.;
		informat mas_rate_1718 				:$30.;
		informat mbl_cohort_1718 			:$30.;
		informat mbl_rate_1718 				:$30.;
		informat mhi_cohort_1718 			:$30.;
		informat mhi_rate_1718 				:$30.;
		informat mtr_cohort_1718 			:$30.;
		informat mtr_rate_1718 				:$30.;
		informat mwh_cohort_1718 			:$30.;
		informat mwh_rate_1718 				:$30.;
		informat cwd_cohort_1718 			:$30.;
		informat cwd_rate_1718 				:$30.;
		informat ecd_cohort_1718 			:$30.;
		informat ecd_rate_1718 				:$30.;
		informat fcs_cohort_1718 			:$30.;
		informat fcs_rate_1718 				:$30.;
		informat hom_cohort_1718 			:$30.;
		informat hom_rate_1718 				:$30.;
		informat lep_cohort_1718 			:$30.;
		informat lep_rate_1718 				:$30.;
		informat date_cur 					:$30.;

	   	format stnam 						$30.;
		format fipst 						$30.;
		format leaid 						$30.;
		format st_leaid 					$30.;
		format leanm 						$30.;
		format ncessch 						$30.;
		format st_schid 					$30.;
		format schnam 						$30.;
		format all_cohort_1718 				$30.;
		format all_rate_1718 				$30.;
		format mam_cohort_1718 				$30.;
		format mam_rate_1718 				$30.;
		format mas_cohort_1718 				$30.;
		format mas_rate_1718 				$30.;
		format mbl_cohort_1718 				$30.;
		format mbl_rate_1718 				$30.;
		format mhi_cohort_1718 				$30.;
		format mhi_rate_1718 				$30.;
		format mtr_cohort_1718 				$30.;
		format mtr_rate_1718 				$30.;
		format mwh_cohort_1718 				$30.;
		format mwh_rate_1718 				$30.;
		format cwd_cohort_1718 				$30.;
		format cwd_rate_1718 				$30.;
		format ecd_cohort_1718 				$30.;
		format ecd_rate_1718 				$30.;
		format fcs_cohort_1718 				$30.;
		format fcs_rate_1718 				$30.;
		format hom_cohort_1718 				$30.;
		format hom_rate_1718 				$30.;
		format lep_cohort_1718 				$30.;
		format lep_rate_1718 				$30.;
		format date_cur 					$30.;

	input
		stnam								$
		fipst								$
		leaid								$
		st_leaid							$
		leanm								$
		ncessch								$
		st_schid							$
		schnam								$
		all_cohort_1718						$
		all_rate_1718						$
		mam_cohort_1718						$
		mam_rate_1718						$
		mas_cohort_1718						$
		mas_rate_1718						$
		mbl_cohort_1718						$
		mbl_rate_1718						$
		mhi_cohort_1718						$
		mhi_rate_1718						$
		mtr_cohort_1718						$
		mtr_rate_1718						$
		mwh_cohort_1718						$
		mwh_rate_1718						$
		cwd_cohort_1718						$
		cwd_rate_1718						$
		ecd_cohort_1718						$
		ecd_rate_1718						$
		fcs_cohort_1718						$
		fcs_rate_1718						$
		hom_cohort_1718						$
		hom_rate_1718						$
		lep_cohort_1718						$
		lep_rate_1718						$
		date_cur							$
		;
run;

%mend grad_import;
*%MEND statement stands for Macro End and instructs SAS that only the programming 
		statements between the %MACRO and %MEND constitute the macro loop.;

*INVOCATION OF THE MACRO GRAD_IMPORT*;
*To invoke the macro, the syntax is simply %<macroname>(<macro var value 1>,<macro var value 2>,...);
*Note that a semi-colon is not required at the end of the line invoking a macro, but it
does not do any harm to include one either.;
%grad_import(grad_rates1, "&raw\Graduation Rates Alabama-Kentucky.csv")
%grad_import(grad_rates2, "&raw\Graduation Rates Louisiana-Rhode Island.csv")
%grad_import(grad_rates3, "&raw\Graduation Rates South Carolina-Wyoming.csv")

*As may have surmised, the code within the macro is exactly the same as what any standard
data step import would look like. The only difference is that the two references that we
put in the beginning of the macro are used in place of the file name and the SAS name.
In this way, we were able to import three separate files by invoking the macro three
times.;

*You can also use macros to do other things. For example, if you wanted to only keep
certain variables from each of the three datasets and sort them. You could do that
in a macro in the following way:;

%macro grad_cleaning(fref);
	data work.&fref;
		set work.&fref;
		keep stnam leanm schnam all_cohort_1718;
	run;

	proc sort data = work.&fref out = work.&fref;
		by stnam;
	run;
%mend grad_cleaning;

%grad_cleaning(grad_rates1)
%grad_cleaning(grad_rates2)
%grad_cleaning(grad_rates3)

*Once you run the commands above, you'll notice that you just ran the cleaning macro
commands on all three datasets. This is a cleaner and less error prone way to write
code.;

*Finally, you might be wondering why we never covered how to write a loop in SAS in any
of the trainings. The simple reason is that they use macro language and they are not
intuitive. Now however, you can run the same macro that we just used in a loop over
grad_rates1, grad_rates2, and grad_rates3 in the following way:;
%macro grad_cleaning2;
	%do  i =  1 %to 3;
		data work.grad_rates&i;
			set work.grad_rates&i;
			keep stnam leanm schnam all_cohort_1718;
		run;

		proc sort data = work.grad_rates&i out = work.grad_rates&i;
			by stnam;
		run;
	%end;
%mend grad_cleaning2;

%grad_cleaning2;
*Note that you can only run loops in a macro. (Loops not inside of a macro are considered
"open code" and SAS won't read them properly.);


******************************
***READING COMPRESSED FILES***
******************************;
*In Lesson 2, we briefly discussed the many challenges of importing big data. Returning
to that, we will now discuss importing compressed (or zipped) files in SAS. Practically,
this is very straightforward, but it does require a bit of explanation for understanding.
If you're working with big data, it is likely in your best interest to compress
that data. Compressing data is a process that has been developed over many years as
programmers have found more efficient methods to store information. This typically 
involves a set of instructions that the computer will read in order to find patterns
in data. For example, if you were to write "pitter patter" in a text file and then compress
it, the computer might compress this by noticing the pattern of "tter" at the end of each
word. It could then replace these four characters with "04" in "patter", so that the
text file will now read "pitter pa04". When the file is "decompressed" (or unzipped),
the computer will see the pattern of "04" in "pa04"  and will replace it with the last 
4 characters of the preceding word ("0" specifies to use the preceding word, and "4"
specifies 4 characters) hence bringing us from "pitter patter" to "pitter pa04" and 
finally back to "pitter patter". Here, this shrunk our data from 13 characters to 
9 characters. Multiply this over millions of rows and hundreds of columns and you 
could save a lot of memory. Now, compression is extremely complicated and modern 
compression algorithms are very expensive. Unix servers typically get 10:1 compression
on each text file, which makes a huge difference when working with hundreds of
gigabytes of data.;

*(Note: this is very similar to how encryption works. The major difference is that compression
algorithms are widely distributed so that you can compress and uncompress data on any
machine or operating system. On the contrary, enryption algorithms are carefully protected
trade secrets, and while they can save memory, they aim to scramble patterns rather than
streamline them.)

*SAS can read compressed files straight from a .zip or .gzip file. This is very
convenient as you can save space and avoid processing data with your local computer,
which might be impossible for you if you have very big data. The exact syntax of
how to read a zip file varies by operating system (different systems have different
decompression algorithms), but all of them are very straightforward.;

*Before we get into reading compressed files, you will need to understand the "filename"
statement. This is a very straightforward SAS statement that just stores some text. It
is particularly useful because SAS will read it as a separate object rather than just
a string, so you can actually type command within a "filename" that SAS can interpret
as it is processing. The syntax for a filename that says "This is a test." is:;

filename test "This is a test.";

*The string "This is a test." can now be accessed in a command by typing "test".;

*In Windows, you will typically use the "zip" command combined with the filename
statment to acces zipped files. This allows you to specify the zip folder, and then you
can reference the file within the zip folder that you want to access within the data step.
In the next line, we specify the inzip filename with the "zip" command preceding the file
path. This will instruct SAS to run this command when it finds "inzip" in the data step.;
filename inzip zip "[FILE PATH]\SAS Training 2020\RawData\Graduation Rates Alabama-Kentucky.zip";

*Now, we write a data step to import the data as we normally would, and we invoke the
"inzip" filename in the infile statement.;
data work.grad_rates1;
	retain
		stnam
		fipst
		leaid
		st_leaid
		leanm
		ncessch
		st_schid
		schnam
		all_cohort_1718
		all_rate_1718
		mam_cohort_1718
		mam_rate_1718
		mas_cohort_1718
		mas_rate_1718
		mbl_cohort_1718
		mbl_rate_1718
		mhi_cohort_1718
		mhi_rate_1718
		mtr_cohort_1718
		mtr_rate_1718
		mwh_cohort_1718
		mwh_rate_1718
		cwd_cohort_1718
		cwd_rate_1718
		ecd_cohort_1718
		ecd_rate_1718
		fcs_cohort_1718
		fcs_rate_1718
		hom_cohort_1718
		hom_rate_1718
		lep_cohort_1718
		lep_rate_1718
		date_cur
		;

%let _EFIERR_ = 0; * set the ERROR detection macro variable *;

*Here, we use the inzip filename and specify the filename using parentheses immediately
following "inzip";
infile inzip(Graduation Rates Alabama-Kentucky.csv) delimiter = "," missover dsd length = reclen firstobs = 2;

		informat stnam 						:$30.;
		informat fipst 						:$30.;
		informat leaid 						:$30.;
		informat st_leaid 					:$30.;
		informat leanm 						:$30.;
		informat ncessch 					:$30.;
		informat st_schid 					:$30.;
		informat schnam 					:$30.;
		informat all_cohort_1718 			:$30.;
		informat all_rate_1718 				:$30.;
		informat mam_cohort_1718 			:$30.;
		informat mam_rate_1718 				:$30.;
		informat mas_cohort_1718 			:$30.;
		informat mas_rate_1718 				:$30.;
		informat mbl_cohort_1718 			:$30.;
		informat mbl_rate_1718 				:$30.;
		informat mhi_cohort_1718 			:$30.;
		informat mhi_rate_1718 				:$30.;
		informat mtr_cohort_1718 			:$30.;
		informat mtr_rate_1718 				:$30.;
		informat mwh_cohort_1718 			:$30.;
		informat mwh_rate_1718 				:$30.;
		informat cwd_cohort_1718 			:$30.;
		informat cwd_rate_1718 				:$30.;
		informat ecd_cohort_1718 			:$30.;
		informat ecd_rate_1718 				:$30.;
		informat fcs_cohort_1718 			:$30.;
		informat fcs_rate_1718 				:$30.;
		informat hom_cohort_1718 			:$30.;
		informat hom_rate_1718 				:$30.;
		informat lep_cohort_1718 			:$30.;
		informat lep_rate_1718 				:$30.;
		informat date_cur 					:$30.;

	   	format stnam 						$30.;
		format fipst 						$30.;
		format leaid 						$30.;
		format st_leaid 					$30.;
		format leanm 						$30.;
		format ncessch 						$30.;
		format st_schid 					$30.;
		format schnam 						$30.;
		format all_cohort_1718 				$30.;
		format all_rate_1718 				$30.;
		format mam_cohort_1718 				$30.;
		format mam_rate_1718 				$30.;
		format mas_cohort_1718 				$30.;
		format mas_rate_1718 				$30.;
		format mbl_cohort_1718 				$30.;
		format mbl_rate_1718 				$30.;
		format mhi_cohort_1718 				$30.;
		format mhi_rate_1718 				$30.;
		format mtr_cohort_1718 				$30.;
		format mtr_rate_1718 				$30.;
		format mwh_cohort_1718 				$30.;
		format mwh_rate_1718 				$30.;
		format cwd_cohort_1718 				$30.;
		format cwd_rate_1718 				$30.;
		format ecd_cohort_1718 				$30.;
		format ecd_rate_1718 				$30.;
		format fcs_cohort_1718 				$30.;
		format fcs_rate_1718 				$30.;
		format hom_cohort_1718 				$30.;
		format hom_rate_1718 				$30.;
		format lep_cohort_1718 				$30.;
		format lep_rate_1718 				$30.;
		format date_cur 					$30.;

	input
		stnam								$
		fipst								$
		leaid								$
		st_leaid							$
		leanm								$
		ncessch								$
		st_schid							$
		schnam								$
		all_cohort_1718						$
		all_rate_1718						$
		mam_cohort_1718						$
		mam_rate_1718						$
		mas_cohort_1718						$
		mas_rate_1718						$
		mbl_cohort_1718						$
		mbl_rate_1718						$
		mhi_cohort_1718						$
		mhi_rate_1718						$
		mtr_cohort_1718						$
		mtr_rate_1718						$
		mwh_cohort_1718						$
		mwh_rate_1718						$
		cwd_cohort_1718						$
		cwd_rate_1718						$
		ecd_cohort_1718						$
		ecd_rate_1718						$
		fcs_cohort_1718						$
		fcs_rate_1718						$
		hom_cohort_1718						$
		hom_rate_1718						$
		lep_cohort_1718						$
		lep_rate_1718						$
		date_cur							$
		;
run;

*You can also run the above command with an Excel file or in a loop if you prefer.;

*While we haven't discussed many of the quirks of Unix-based SAS, we will address how to
import compressed data in Unix-based SAS here for completeness. Similarly to the example
above, the syntax for declaring these filenames is:
*	filename <fileref> pipe "<unix command to extract data to standard output>  <filepath/filename"
*	filename = SAS command to associate file information with the provided fileref
*	fileref  = user provided name that will be used to refer to the file in the program
*	pipe	 = instructs SAS to invoke a program outside of the SAS system. In this case
			   the unix command to read compressed data to standard output (stdout).

*	examples of unix commands to read compressed data
*		1) unzip -c  The -c option instructs unix to flow the data to stdout output (text)
*		2) zcat	     For use with .gz (gzip) files. Allows unix to "read" the file without
*			     uncompressing first.;

*We can run these examples because these are Unix specific, but example syntax is below:;
filename p1 pipe "unzip -c /[FILE PATH]/FILENAME2.ZIP";
filename p2 pipe "zcat /[FILE PATH]/FILENAME2.GZIP";

*You could invoke these either in a macro datastep or by specifying p1 instead of the
file path in the infile command.



