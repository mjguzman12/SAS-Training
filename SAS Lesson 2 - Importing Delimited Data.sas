************************
************************
*****SAS LESSON TWO*****
************************
************************;


***********
***INTRO***
***********;
*Following up on Lesson 1, you now know something about the basic syntax and structure of
SAS. This lesson will introduce the difference between proc steps and data steps, and
then it goes into depth on importing datasets.;


*******************************
***PROC STEPS VS. DATA STEPS***
*******************************
*Having talked briefly about why programmers choose to use SAS over other languages,
it's time to delve into the nitty gritty of manipulating data in SAS. First and
foremost is the need for "proc" steps and "data" steps in SAS. A "step" in SAS is simply a
command, just like you would run from the command bar in Stata or R. As you don't have any
data in memory, every step needs to end with a "run" statement to tell SAS to run a set
of commands over a dataset.;

*As was briefly discussed in Lesson 1, there are two types of "steps" (or commands) in SAS.
PROC steps relate to data procedures such as importing data. PROC steps are so named 
because they are really "procedures" to call other programs. For example, if you look 
carefully through the log file of your Lesson 1 script near the "proc import" command,
you'll notice that there is a "Generated SAS Datastep Code" block immediately underneath 
your command. This is because you didn't actually program anything in your import - you 
actually just ran a procedure that was preset to run a set of code. In fact, most 
statistical programming languages are set up this way. Stata uses the simple syntax of
"import delimited" and guesses things such as variable names, variable types,
and delimiters. R's "read.csv" and "read_csv" commands do similar things. These
"procedural commands" allow us as analysts to leapfrog over the complex programming
necessary to program an import and move on to analysis as quickly as possible.;

*There are in fact three levels of SAS programming: PROC steps, DATA steps, and
SAS macros. You can think of these in terms of building blocks. PROC steps are built
on top of DATA steps, and DATA steps are built on top of SAS macros. Each PROC step 
might call multiple data steps. PROC steps have easier syntax than DATA steps and
they are easier to write, and there are only about 300 of them written. These PROC
steps are written by programmers so that the most common needs when manipulating data
are covered by PROC steps.;

*The DATA step can be thought of as the individual steps that make up a PROC step,
and you will be required to be much more specific with your commands as you use
DATA steps. For example, let's import the Capital Bike Share Locations dataset
via a PROC step and a DATA step. This uses the same import syntax that you used to import
the practice dataset in lesson 1, and we now include the "delimiter" statement to specify
that the delimiter is a comma:;
proc import datafile = "[FILE PATH]\SAS Training 2020\RawData\Capital_Bike_Share_Locations.csv"
	out = work.bike_locations
	dbms = csv
	replace;
	delimiter = ",";
run;

*Notably, let's review how to view this dataset. As we've discussed, you are creating this
dataset in your "work" library. You can find it in the explorer pane to the right by
clicking on "Libraries" followed by "Work", and then double clicking on the "Bike_locations"
dataset.

*The following DATA step gives you more control over your import. This will allow 
you to import finicky data, but it requires many more specifications than the PROC 
import command, including specifying the name and type of every variable.;

data work.bike_locations2;

infile "[FILE PATH]\SAS Training 2020\RawData\Capital_Bike_Share_Locations.csv"
dlm = "," firstobs = 2;

input 
	object_id $
	id $
	address $
	terminal_number $
	latitude
	longitude
	installed $
	locked $
	install_date $
	removal_date $
	temporary_install $
	number_of_bikes $
	number_of_empty_docks $
	X $
	Y $
	se_anno_cad_data $
	owner $
	;
run;

*Let's break down the data step that you just used. This starts with "data" to indicate
that this is a data step, and this is immediately followed by the name of the file that
you are importing (note the libname.filename structure). Following this, we use an "infile"
command. This is just the type of data step that you will use, and following this, SAS
expects the file path as well as the specifications of the file. We'll get into the many
different specifications later, but for now, just know that we are specifying the delimiter
(dlm) and that the first observation is on the second line (typical because of the var names).
Finally, we put the input command in which we list the name of all of the variables. Just
after each name, we either put a "$" for "string", or leave a space after it. The absence
of a dollar sign indicates that the variable is numeric (see "latitude" and "longitude" as
examples).

*Now, the above example uses a relatively clean dataset. A good example of why you might 
need to use a DATA step to import data is given by the following dataset. The import 
procedure used above does not work on this dataset because SAS finds values of multiple 
types when it tries to guess the values of variables. This command will run, but SAS will
give you multiple errors and a note that says that the dataset did not import correctly.;
proc import datafile = "[FILE PATH]\SAS Training 2020\RawData\1-2016_QHP_Landscape_Individual_Market_Medical.csv"
	out = work.raw_deductibles
	dbms = csv
	replace;
	delimiter = ",";
run;

*Here, you likely would want to use a datastep to format the variables properly. With large
datasets, the formats are sometimes provided in the data dictionary, but if they are not,
then you may need to visually inspect the data to determine the proper formats. Here is an
example of a datastep to import this dataset that will run without an error.;

data work.raw_deductibles2;

*The following command uses a SAS macro to set the error macro detection variable. It is
standard in an infile datastep, but we haven't quite learned about macro variables yet.
For now, just trust that it is useful to have it here, and we'll come back to its exact
purpose in lesson 4.;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */

*The first step with any messy data is to use a retain statement. This is not necessary,
but its purpose is to keep all of the variables in order. This is simply the list of
variables as they appear in the dataset, and as you'll see in the next step, it is
very easy to provide the formats of these variables out of order.; 
	retain state_code
			county_name
			metal_level
			issuer_name
			plan_id
			plan_marketing_name
			plan_type
			rating_area
			child_only_offering
			source
			cs_phone_number_local
			cs_phone_number_toll_free
			cs_phone_number_tty
			network_url
			plan_brochure_url
			summ_benefits_url
			drug_formulary_url
			accredidation
			adult_dental
			child_dental
			ehb_percent
			premium_scenarios
			premium_child
			premium_adult_ind_21
			premium_adult_ind_27
			premium_adult_ind_30
			premium_adult_ind_40
			premium_adult_ind_50
			premium_adult_ind_60
			premium_couple_21
			premium_couple_30
			premium_couple_40
			premium_couple_50
			premium_couple_60
			couple_child_21
			couple_child_30
			couple_child_40
			couple_child_50
			couple_2_children_21
			couple_2_children_30
			couple_2_children_40
			couple_2_children_50
			couple_3_children_21
			couple_3_children_30
			couple_3_children_40
			couple_3_children_50
			individual_1_child_21
			individual_1_child_30
			individual_1_child_40
			individual_1_child_50
			individual_2_children_21
			individual_2_children_30
			individual_2_children_40
			individual_2_children_50
			individual_3_children_21
			individual_3_children_30
			individual_3_children_40
			individual_3_children_50
			standard_plan_cost_sharing
			medical_deductible_ind_stan
			drug_deductible_ind_stan
			medical_deductible_fam_stan
			drug_deductible_fam_stand
			medical_deductible_familypp_stan
			drug_deductible_fampp_stan
			med_max_out_of_pocket_ind_stan
			drug_max_out_of_pocket_ind_stan
			med_max_out_of_pocket_fam_stan
			drug_max_out_of_pocket_fam_stan
			med_max_out_of_pocket_fampp_stan
			drug_max_outofpocket_fampp_stan
			primary_care_physician_stan
			specialist_stan
			emergency_room_stan
			inpatient_facility_stan
			inpatient_physician_stand
			generic_drugs_stan
			preferred_brand_drugs_stan
			nonpreferred_brand_drugs_stan
			specialty_drugs_stan
			percent73_actuarial_value_silver
			med_ded_ind_73percent
			drug_ded_individual_73_percent
			med_ded_fam_73_percent
			drug_ded_family_73_percent
			med_ded_familypp_73_percent
			drug_ded_fampp_73_percent
			med_max_oop_ind_73_percent
			drug_max_oopt_ind_73_percent
			med_max_oop_fam_73_percent
			drug max_oop_fam_73_percent
			med_max_oop_fampp_73_percent
			drug_max_oop_fampp_73_percent
			pc_physician_73_percent
			specialist_73_percent
			emergency_room_73_percent
			inpatient_facility_73_percent
			inpatient_physician_73_percent
			generic_drugs_73_percent
			preferred_brand_drugs_73_percent
			nonpref_brand_drugs_73_percent
			specialty_drugs_73_percent
			percent87_actuarial_value_silver
			med_ded_ind_87_percent
			drug_ded_ind_87_percent
			med_ded_family_87_percent
			drug_ded_family_87_percent
			med_ded_fampp_87_percent
			drug_ded_fampp_87_percent
			med_max_oop_ind_87_percent
			drug_max_oop_ind_87_percent
			med_max_oop_fam_87_percent
			drug_max_oop_fam_87_percent
			med_max_oop_fampp_87_percent
			drug_max_oop_fampp_87percent
			pc_physician_percent
			specialist_87_percent
			emergency_room_87_percent
			inpatient_facility_87_percent
			inpatient_physician_87_percent
			generic_drugs_87_percent
			preferred_brand_drugs_87_percent
			nonpref_brand_drugs_87_percent
			specialty_drugs_87_percent
			percent94_actuarial_value_silver
			med_ded_ind_94_percent
			drug_deductible_ind_94_percent
			med_ded_fam_94_percent
			drug_ded_fam_94_percent
			med_ded_fampp_94_percent
			drug_ded_fampp_94_percent
			med_max_oop_ind_94_percent
			drug_max_oop_ind_94_percent
			med_max_oop_fam_94_percent
			drug_max_oop_fam_94_percent
			med_max_oop_fampp_94_percent
			drug_max_oop_fampp_94_percent
			pc_physician_94_percent
			specialist_94_percent
			emergency_room_94_percent
			inpatient_facility_94_percent
			inpatient_physician_94_percent
			generic_drugs_94_percent
			preferred_brand_drugs_94_percent
			nonpref_brand_drugs_94_percent
			specialty_drugs_94_percent;

*Now, we come to our infile statement. This is similar to the one we used in the datastep
above, but now we add the specifications "DSD" (instructs SAS to treat values as enclosed
in quotes), missover (instructs SAS to skip over missing values), and length, which
instructs SAS to set the length of each value equal to the length of the value, without
trimming it.;
infile "[FILE PATH]\SAS Training 2020\RawData\1-2016_QHP_Landscape_Individual_Market_Medical.csv"
dlm = "," DSD missover firstobs = 2 length = reclen;

	*following the infile statement, we have the "informat" statements. These statements
	go variable by variable to tell SAS what the format of each variable is. The syntax is:
	"informat varname :$2.";
	*Here, the presence or absence of a dollar sign indicates whether
	the variable is a string or not, and the number indicates the length. Also, the colon
	before the format is not required, but it is recommended that you always use it
	as SAS syntax prefers it with some informats. Also, note the semicolon at the end of each
	line.;
		informat state_code									:$2.;
		informat county_name								:$14.;
		informat metal_level								:$12.;
		informat issuer_name								:$40.;
		informat plan_id									:$14.;
		informat plan_marketing_name						:$63.;
		informat plan_type									:$3.;
		informat rating_area								:$13.;
		informat child_only_offering						:$27.;
		informat source										:$5.;
		informat cs_phone_number_local						:$14.;
		informat cs_phone_number_toll_free					:$14.;
		informat cs_phone_number_tty						:$14.;
		informat network_url								:$70.;
		informat plan_brochure_url							:$70.;
		informat summ_benefits_url							:$70.;
		informat drug_formulary_url							:$70.;
		informat accredidation								:$4.;
		informat adult_dental								:$2.;
		informat child_dental								:$2.;
		informat ehb_percent								:$6.;
		informat premium_scenarios							:$2.;
		informat premium_child								:$8.;
		informat premium_adult_ind_21						:$8.;
		informat premium_adult_ind_27						:$8.;
		informat premium_adult_ind_30						:$8.;
		informat premium_adult_ind_40						:$8.;
		informat premium_adult_ind_50						:$8.;
		informat premium_adult_ind_60						:$8.;
		informat premium_couple_21							:$8.;
		informat premium_couple_30							:$8.;
		informat premium_couple_40							:$8.;
		informat premium_couple_50							:$8.;
		informat premium_couple_60							:$8.;
		informat couple_child_21							:$8.;
		informat couple_child_30							:$8.;
		informat couple_child_40							:$8.;
		informat couple_child_50							:$8.;
		informat couple_2_children_21						:$8.;
		informat couple_2_children_30						:$8.;
		informat couple_2_children_40						:$8.;
		informat couple_2_children_50						:$8.;
		informat couple_3_children_21						:$8.;
		informat couple_3_children_30						:$8.;
		informat couple_3_children_40						:$8.;
		informat couple_3_children_50						:$8.;
		informat individual_1_child_21						:$8.;
		informat individual_1_child_30						:$8.;
		informat individual_1_child_40						:$8.;
		informat individual_1_child_50						:$8.;
		informat individual_2_children_21					:$8.;
		informat individual_2_children_30					:$8.;
		informat individual_2_children_40					:$8.;
		informat individual_2_children_50					:$8.;
		informat individual_3_children_21					:$8.;
		informat individual_3_children_30					:$8.;
		informat individual_3_children_40					:$8.;
		informat individual_3_children_50					:$8.;
		informat standard_plan_cost_sharing					:$12.;
		informat medical_deductible_ind_stan				:$8.;
		informat drug_deductible_ind_stan					:$12.;
		informat medical_deductible_fam_stan				:$8.;
		informat drug_deductible_fam_stand					:$12.;
		informat medical_deductible_familypp_stan			:$8.;
		informat drug_deductible_fampp_stan					:$12.;
		informat med_max_out_of_pocket_ind_stan				:$8.;
		informat drug_max_out_of_pocket_ind_stan			:$12.;
		informat med_max_out_of_pocket_fam_stan				:$8.;
		informat drug_max_out_of_pocket_fam_stan			:$12.;
		informat med_max_out_of_pocket_fampp_stan			:$8.;	
		informat drug_max_outofpocket_fampp_stan			:$12.;
		informat primary_care_physician_stan				:$12.;
		informat specialist_stan							:$12.;
		informat emergency_room_stan						:$12.;
		informat inpatient_facility_stan					:$12.;
		informat inpatient_physician_stand					:$12.;
		informat generic_drugs_stan							:$12.;
		informat preferred_brand_drugs_stan					:$12.;
		informat nonpreferred_brand_drugs_stan				:$12.;
		informat specialty_drugs_stan						:$12.;
		informat percent73_actuarial_value_silver			:$12.;
		informat med_ded_ind_73percent						:$12.;
		informat drug_ded_individual_73_percent				:$12.;
		informat med_ded_fam_73_percent						:$12.;
		informat drug_ded_family_73_percent					:$12.;
		informat med_ded_familypp_73_percent				:$8.;
		informat drug_ded_fampp_73_percent					:$20.;
		informat med_max_oop_ind_73_percent					:$20.;
		informat drug_max_oopt_ind_73_percent				:$20.;
		informat med_max_oop_fam_73_percent					:$20.;
		informat drug max_oop_fam_73_percent				:$20.;
		informat med_max_oop_fampp_73_percent				:$20.;
		informat drug_max_oop_fampp_73_percent				:$20.;
		informat pc_physician_73_percent					:$20.;
		informat specialist_73_percent						:$20.;
		informat emergency_room_73_percent					:$20.;
		informat inpatient_facility_73_percent				:$20.;
		informat inpatient_physician_73_percent				:$20.;
		informat generic_drugs_73_percent					:$20.;
		informat preferred_brand_drugs_73_percent			:$20.;
		informat nonpref_brand_drugs_73_percent				:$20.;
		informat specialty_drugs_73_percent					:$20.;
		informat percent87_actuarial_value_silver			:$20.;
		informat med_ded_ind_87_percent						:$8.;
		informat drug_ded_ind_87_percent					:$20.;
		informat med_ded_family_87_percent					:$20.;
		informat drug_ded_family_87_percent					:$20.;
		informat med_ded_fampp_87_percent					:$20.;
		informat drug_ded_fampp_87_percent					:$20.;
		informat med_max_oop_ind_87_percent					:$20.;
		informat drug_max_oop_ind_87_percent				:$20.;
		informat med_max_oop_fam_87_percent					:$8.;
		informat drug_max_oop_fam_87_percent				:$20.;
		informat med_max_oop_fampp_87_percent				:$20.;
		informat drug_max_oop_fampp_87percent				:$20.;
		informat pc_physician_percent						:$20.;
		informat specialist_87_percent						:$20.;
		informat emergency_room_87_percent					:$20.;
		informat inpatient_facility_87_percent				:$20.;
		informat inpatient_physician_87_percent				:$20.;
		informat generic_drugs_87_percent					:$20.;
		informat preferred_brand_drugs_87_percent			:$20.;
		informat nonpref_brand_drugs_87_percent				:$20.;
		informat specialty_drugs_87_percent					:$20.;
		informat percent94_actuarial_value_silver			:$20.;
		informat med_ded_ind_94_percent						:$8.;
		informat drug_deductible_ind_94_percent				:$20.;
		informat med_ded_fam_94_percent						:$8.;
		informat drug_ded_fam_94_percent					:$20.;
		informat med_ded_fampp_94_percent					:$8.;
		informat drug_ded_fampp_94_percent					:$20.;
		informat med_max_oop_ind_94_percent					:$8.;
		informat drug_max_oop_ind_94_percent				:$20.;
		informat med_max_oop_fam_94_percent					:$20.;
		informat drug_max_oop_fam_94_percent				:$20.;
		informat med_max_oop_fampp_94_percent				:$8.;
		informat drug_max_oop_fampp_94_percent				:$20.;
		informat pc_physician_94_percent					:$20.;
		informat specialist_94_percent						:$20.;
		informat emergency_room_94_percent					:$20.;
		informat inpatient_facility_94_percent				:$20.;
		informat inpatient_physician_94_percent				:$20.;
		informat generic_drugs_94_percent					:$20.;
		informat preferred_brand_drugs_94_percent			:$20.;
		informat nonpref_brand_drugs_94_percent				:$20.;
		informat specialty_drugs_94_percent					:$20.;		

	*following the "informat" statements, we have the "format" statements. There is an
	important distinction here: informat tells SAS how to read the variables as it imports,
	and format tells SAS how to format the variables in the dataset. For most variable
	types, the informats and formats will be virtually the same. Date formatting is usually
	a little different, but for the most part, informat and format statements track
	each other pretty well. Similar to the informat statements The syntax is
	"format varname $2.";   
	*Here, the presence or absence of a dollar sign again indicates
	whether the variable is a string or not, and the number indicates the length. Also,
	there is not a colon before the format, unlike the informat comamnds. Once again, 
	note the semicolon at the end of each line.;
		format state_code									$2.;
		format county_name									$14.;
		format metal_level									$12.;
		format issuer_name									$40.;
		format plan_id										$14.;
		format plan_marketing_name							$63.;
		format plan_type									$3.;
		format rating_area									$13.;
		format child_only_offering							$27.;
		format source										$5.;
		format cs_phone_number_local						$14.;
		format cs_phone_number_toll_free					$14.;
		format cs_phone_number_tty							$14.;
		format network_url									$70.;
		format plan_brochure_url							$70.;
		format summ_benefits_url							$70.;
		format drug_formulary_url							$70.;
		format accredidation								$4.;
		format adult_dental									$2.;
		format child_dental									$2.;
		format ehb_percent									$6.;
		format premium_scenarios							$2.;
		format premium_child								$8.;
		format premium_adult_ind_21							$8.;
		format premium_adult_ind_27							$8.;
		format premium_adult_ind_30							$8.;
		format premium_adult_ind_40							$8.;
		format premium_adult_ind_50							$8.;
		format premium_adult_ind_60							$8.;
		format premium_couple_21							$8.;
		format premium_couple_30							$8.;
		format premium_couple_40							$8.;
		format premium_couple_50							$8.;
		format premium_couple_60							$8.;
		format couple_child_21								$8.;
		format couple_child_30								$8.;
		format couple_child_40								$8.;
		format couple_child_50								$8.;
		format couple_2_children_21							$8.;
		format couple_2_children_30							$8.;
		format couple_2_children_40							$8.;
		format couple_2_children_50							$8.;
		format couple_3_children_21							$8.;
		format couple_3_children_30							$8.;
		format couple_3_children_40							$8.;
		format couple_3_children_50							$8.;
		format individual_1_child_21						$8.;
		format individual_1_child_30						$8.;
		format individual_1_child_40						$8.;
		format individual_1_child_50						$8.;
		format individual_2_children_21						$8.;
		format individual_2_children_30						$8.;
		format individual_2_children_40						$8.;
		format individual_2_children_50						$8.;
		format individual_3_children_21						$8.;
		format individual_3_children_30						$8.;
		format individual_3_children_40						$8.;
		format individual_3_children_50						$8.;
		format standard_plan_cost_sharing					$12.;
		format medical_deductible_ind_stan					$8.;
		format drug_deductible_ind_stan						$12.;
		format medical_deductible_fam_stan					$8.;
		format drug_deductible_fam_stand					$12.;
		format medical_deductible_familypp_stan				$8.;
		format drug_deductible_fampp_stan					$12.;
		format med_max_out_of_pocket_ind_stan				$8.;
		format drug_max_out_of_pocket_ind_stan				$12.;
		format med_max_out_of_pocket_fam_stan				$8.;
		format drug_max_out_of_pocket_fam_stan				$12.;
		format med_max_out_of_pocket_fampp_stan				$8.;	
		format drug_max_outofpocket_fampp_stan				$12.;
		format primary_care_physician_stan					$12.;
		format specialist_stan								$12.;
		format emergency_room_stan							$12.;
		format inpatient_facility_stan						$12.;
		format inpatient_physician_stand					$12.;
		format generic_drugs_stan							$12.;
		format preferred_brand_drugs_stan					$12.;
		format nonpreferred_brand_drugs_stan				$12.;
		format specialty_drugs_stan							$12.;
		format percent73_actuarial_value_silver				$12.;
		format med_ded_ind_73percent						$12.;
		format drug_ded_individual_73_percent				$12.;
		format med_ded_fam_73_percent						$12.;
		format drug_ded_family_73_percent					$12.;
		format med_ded_familypp_73_percent					$8.;
		format drug_ded_fampp_73_percent					$20.;
		format med_max_oop_ind_73_percent					$20.;
		format drug_max_oopt_ind_73_percent					$20.;
		format med_max_oop_fam_73_percent					$20.;
		format drug max_oop_fam_73_percent					$20.;
		format med_max_oop_fampp_73_percent					$20.;
		format drug_max_oop_fampp_73_percent				$20.;
		format pc_physician_73_percent						$20.;
		format specialist_73_percent						$20.;
		format emergency_room_73_percent					$20.;
		format inpatient_facility_73_percent				$20.;
		format inpatient_physician_73_percent				$20.;
		format generic_drugs_73_percent						$20.;
		format preferred_brand_drugs_73_percent				$20.;
		format nonpref_brand_drugs_73_percent				$20.;
		format specialty_drugs_73_percent					$20.;
		format percent87_actuarial_value_silver				$20.;
		format med_ded_ind_87_percent						$8.;
		format drug_ded_ind_87_percent						$20.;
		format med_ded_family_87_percent					$20.;
		format drug_ded_family_87_percent					$20.;
		format med_ded_fampp_87_percent						$20.;
		format drug_ded_fampp_87_percent					$20.;
		format med_max_oop_ind_87_percent					$20.;
		format drug_max_oop_ind_87_percent					$20.;
		format med_max_oop_fam_87_percent					$8.;
		format drug_max_oop_fam_87_percent					$20.;
		format med_max_oop_fampp_87_percent					$20.;
		format drug_max_oop_fampp_87percent					$20.;
		format pc_physician_percent							$20.;
		format specialist_87_percent						$20.;
		format emergency_room_87_percent					$20.;
		format inpatient_facility_87_percent				$20.;
		format inpatient_physician_87_percent				$20.;
		format generic_drugs_87_percent						$20.;
		format preferred_brand_drugs_87_percent				$20.;
		format nonpref_brand_drugs_87_percent				$20.;
		format specialty_drugs_87_percent					$20.;
		format percent94_actuarial_value_silver				$20.;
		format med_ded_ind_94_percent						$8.;
		format drug_deductible_ind_94_percent				$20.;
		format med_ded_fam_94_percent						$8.;
		format drug_ded_fam_94_percent						$20.;
		format med_ded_fampp_94_percent						$8.;
		format drug_ded_fampp_94_percent					$20.;
		format med_max_oop_ind_94_percent					$8.;
		format drug_max_oop_ind_94_percent					$20.;
		format med_max_oop_fam_94_percent					$20.;
		format drug_max_oop_fam_94_percent					$20.;
		format med_max_oop_fampp_94_percent					$8.;
		format drug_max_oop_fampp_94_percent				$20.;
		format pc_physician_94_percent						$20.;
		format specialist_94_percent						$20.;
		format emergency_room_94_percent					$20.;
		format inpatient_facility_94_percent				$20.;
		format inpatient_physician_94_percent				$20.;
		format generic_drugs_94_percent						$20.;
		format preferred_brand_drugs_94_percent				$20.;
		format nonpref_brand_drugs_94_percent				$20.;
		format specialty_drugs_94_percent					$20.;	

*Finally, as we used above, use the input statement to input the variables into the output
dataset, once again using the dollar sign to indicate string or not.;
input 
	state_code $
	county_name $
	metal_level	$
	issuer_name $
	plan_id $
	plan_marketing_name $
	plan_type $
	rating_area $
	child_only_offering $
	source $
	cs_phone_number_local $
	cs_phone_number_toll_free $
	cs_phone_number_tty $
	network_url $
	plan_brochure_url $
	summ_benefits_url $
	drug_formulary_url $
	accredidation $
	adult_dental $
	child_dental $
	ehb_percent $
	premium_scenarios $
	premium_child $
	premium_adult_ind_21 $
	premium_adult_ind_27 $
	premium_adult_ind_30 $
	premium_adult_ind_40 $
	premium_adult_ind_50 $
	premium_adult_ind_60 $
	premium_couple_21 $
	premium_couple_30 $
	premium_couple_40 $
	premium_couple_50 $
	premium_couple_60 $
	couple_child_21 $
	couple_child_30 $
	couple_child_40 $
	couple_child_50 $
	couple_2_children_21 $
	couple_2_children_30 $
	couple_2_children_40 $
	couple_2_children_50 $
	couple_3_children_21 $
	couple_3_children_30 $
	couple_3_children_40 $
	couple_3_children_50 $
	individual_1_child_21 $
	individual_1_child_30 $
	individual_1_child_40 $
	individual_1_child_50 $
	individual_2_children_21 $
	individual_2_children_30 $
	individual_2_children_40 $
	individual_2_children_50 $
	individual_3_children_21 $
	individual_3_children_30 $
	individual_3_children_40 $
	individual_3_children_50 $
	standard_plan_cost_sharing $
	medical_deductible_ind_stan $
	drug_deductible_ind_stan $
	medical_deductible_fam_stan $
	drug_deductible_fam_stand $
	medical_deductible_familypp_stan $
	drug_deductible_fampp_stan $
	med_max_out_of_pocket_ind_stan $
	drug_max_out_of_pocket_ind_stan $
	med_max_out_of_pocket_fam_stan $
	drug_max_out_of_pocket_fam_stan $
	med_max_out_of_pocket_fampp_stan $
	drug_max_outofpocket_fampp_stan $
	primary_care_physician_stan $
	specialist_stan $
	emergency_room_stan $
	inpatient_facility_stan $
	inpatient_physician_stand $
	generic_drugs_stan $
	preferred_brand_drugs_stan $
	nonpreferred_brand_drugs_stan $
	specialty_drugs_stan $
	percent73_actuarial_value_silver $
	med_ded_ind_73percent $
	drug_ded_individual_73_percent $
	med_ded_fam_73_percent $
	drug_ded_family_73_percent $
	med_ded_familypp_73_percent $
	drug_ded_fampp_73_percent $
	med_max_oop_ind_73_percent $
	drug_max_oopt_ind_73_percent $
	med_max_oop_fam_73_percent $
	drug max_oop_fam_73_percent $
	med_max_oop_fampp_73_percent $
	drug_max_oop_fampp_73_percent $
	pc_physician_73_percent $
	specialist_73_percent $
	emergency_room_73_percent $
	inpatient_facility_73_percent $
	inpatient_physician_73_percent $
	generic_drugs_73_percent $
	preferred_brand_drugs_73_percent $
	nonpref_brand_drugs_73_percent $
	specialty_drugs_73_percent $
	percent87_actuarial_value_silver $
	med_ded_ind_87_percent $
	drug_ded_ind_87_percent $
	med_ded_family_87_percent $
	drug_ded_family_87_percent $
	med_ded_fampp_87_percent $
	drug_ded_fampp_87_percent $
	med_max_oop_ind_87_percent $
	drug_max_oop_ind_87_percent $
	med_max_oop_fam_87_percent $
	drug_max_oop_fam_87_percent $
	med_max_oop_fampp_87_percent $
	drug_max_oop_fampp_87percent $
	pc_physician_percent $
	specialist_87_percent $
	emergency_room_87_percent $
	inpatient_facility_87_percent $
	inpatient_physician_87_percent $
	generic_drugs_87_percent $
	preferred_brand_drugs_87_percent $
	nonpref_brand_drugs_87_percent $
	specialty_drugs_87_percent $
	percent94_actuarial_value_silver $
	med_ded_ind_94_percent $
	drug_deductible_ind_94_percent $
	med_ded_fam_94_percent $
	drug_ded_fam_94_percent $
	med_ded_fampp_94_percent $
	drug_ded_fampp_94_percent $
	med_max_oop_ind_94_percent $
	drug_max_oop_ind_94_percent $
	med_max_oop_fam_94_percent $
	drug_max_oop_fam_94_percent $
	med_max_oop_fampp_94_percent $
	drug_max_oop_fampp_94_percent $
	pc_physician_94_percent $
	specialist_94_percent $
	emergency_room_94_percent $
	inpatient_facility_94_percent $
	inpatient_physician_94_percent $
	generic_drugs_94_percent $
	preferred_brand_drugs_94_percent $
	nonpref_brand_drugs_94_percent $
	specialty_drugs_94_percent $

	;
run;

*Now, if you ran that datastep, you should see that the entire file imported without error.
If you look back at the proc import statement in your log, you'll notice that the proc import
invoked many of the same commands that you ran in the datastep, but because you could specify
everything without guessing, your datastep ran without error, whereas SAS produced errors when 
running the proc import.;

*This is a good illustration of why you will need to use data steps in SAS. Typically,
when data is clean, you will likely be able to use proc steps to run available code over your
data. When data is not clean, you will need to use more datasteps to clean it first, and
data steps require more specifications to get the data into just the right format.;

*Returning to our discussion above, there is in fact a third level of SAS programming
called SAS macros. Macros represent the nitty-gritty of SAS, and you can write complex
programs within their framework. If you're writing a command that is very repetetive
(such as importing many datasets with the same variable information), or if you need 
to perform a calculation many times (such as calculate market shares based on different
data), then it probably makes sense to invest the time to write a macro. We'll get into
a few SAS macros in lesson 4, but suffice to say that SAS macros are generally complicated
and difficult to write, so usually you shouldn't touch this level of SAS programming unless 
it is necessary.;


*******************************
***HOW TO IMPORT DATA DETAIL***
*******************************;
*Now that you know the differences between data and proc steps, lets get into the detail
of importing data. Importing data in SAS can range from being very straightforward to
extraordinarily complicated. This is because of how detailed you may need or want
to be when specifying your import. 

*A word of advice: it's all about the import in SAS. One more time: IT IS ALL ABOUT
THE IMPORT IN SAS. You may have noticed that the data infile example above was quite
long, and you may have even wondered how long it would take to type all of that. On
a complicated import, it could easily take over 2 hours just to write the code to
import your data in a data step. Quite often in SAS, you may find yourself working
with data that is too big for Stata or R, and you should always keep in mind that you
can do an enormous number of things in the import. You can import your data such that
you only keep the columns you need, you can specify the types of variables, and
you can import the data in such a way that it is already pretty clean when you get it.
With any big data, you are trying to minimize the cleaning you need to do after the
import because any cleaning will take extra time. Therefore, try to do as much as
possible in the import step.;

*The recommended strategy to import data is usually to start with proc import.
If that works, great! If it doesn't, there are a few tricks with proc import syntax
that could help. Here is an example of proc import with all of the extra specifications
that you might need:;

proc import datafile = "[FILE PATH]\SAS Training 2020\RawData\Capital_Bike_Share_Locations.csv"
	out = work.bike_locations
	dbms = csv
	replace;
	getnames = yes;
	datarow = 2;
	guessingrows = 20;
	delimiter = ",";
run;

*As we discussed in lesson 1, proc import starts with the datafile statement which specifies
the filepath, and then uses the "out" statement to specify the name of the new dataset
in SAS. Again, "dbms" is short for "database management system," and you just need to
type the file extension to import data here. The replace statement replaces the dataset if
there is already a dataset with that name in your library.;

*Additionally, here is a summary of common proc import specifications as illustrated
above:

***getnames: short for "get column names". This just tells SAS to use the first row as
	variable names.

***datarow: short for "first row of data". This tells SAS which row to begin reading
	data from.

***guessingrows: short for "variable type guessing rows". This tells SAS how many rows
	it should use to determine the variable types. The default is 20, but beware, if you
	set this too high, it will significantly increase the time it will take to import your
	data.

***delimiter: this just tells SAS what the delimiter is. If not provided, SAS will guess
	the delimiter based on the dbms.;

*Now, even with all of these specifications, sometimes you may just want to test an import
to scan some data. In this case, you may just want to use the "obs" option to set the number
of observations that SAS reads. For example, you can change the number of observations that
SAS reads using the following command:;
options obs = 500;

*Be very careful though, this will limit SAS such that it will only read and process
500 observations from any dataset moving forward. So, the following proc import will
only import 500 observations:;

proc import datafile = "[FILE PATH]\SAS Training 2020\RawData\Capital_Bike_Share_Locations.csv"
	out = work.bike_locations
	dbms = csv
	replace;
	getnames = yes;
	datarow = 2;
	guessingrows = 20;
	delimiter = ",";
run;

*But this command will import all 542 of the observations because we set obs to max;
options obs = MAX;

proc import datafile = "[FILE PATH]\SAS Training 2020\RawData\Capital_Bike_Share_Locations.csv"
	out = work.bike_locations
	dbms = csv
	replace;
	getnames = yes;
	datarow = 2;
	guessingrows = 20;
	delimiter = ",";
run;

*If proc import simply isn't going to cut it for you (or you're trying to clean data in
the import (which is strongly recommended)), then you need to move on to writing a datastep.
In an ideal world, you might have a data dictionary which will give you the names and formats
of your variables. This would be a very good starting point for your datastep. 
If you don't have that, then you likely need to start with proc import using the obs option
above. Just let SAS import 1000 observations and look at what you're dealing with. Once
you know that, you can visually inspect the data and determine the variable names,
variable types, and order of the variables.;

*Once you have your variable list, informats, and formats, you are ready to write your
data step. In addition to this information though, you may need certain specifications
in your infile command to import your data properly. Here is a summary list of some 
useful specifications to know when importing data. There are many more possible 
specifications than this, so this is just a short list of common ones:

***dlm: short for delimiter. SAS can read literally anything as a delimiter.

***firstobs: short for "first observation row". This is usually 2 if your dataset
	has variable names.

***DSD: short for "delimiter sensitive data". This specifies that data enclosed in
	quotation marks do not contain delimiters. (i.e. commas inside quotes don't matter).
	I've never seen an import command that doesn't use this specification.

***missover: short for "if missing, skip over". This specification tells SAS that
	blank observations are not new lines, but rather simply missing or blank.

***lrecl: short for "logical record length". This specifies how long an observation
	can be, and the max in SAS is 32767 characters or numerals. Therefore, this spec
	is practically always set to 32767 (256 is the default).

***termstr: short for "termination of string". The setting of this varies by operating
	system as different systems use different characters for line breaks, but in Windows, 
	this is usually set to crlf so that line breaks represent new rows. 

***ignoredoseof: useful specification to ensure that SAS doesn't stop importing if it
	finds certain "ending characters" such as arrows, hex characters, or other spurious
	string values. This specification is only necessary for Windows-based SAS because 
	Windows interprets arrows and hexes as ending characters.;

*The following example code will show you how to import data using some of the
specifications listed above.;

data work.dept_of_ed_data;
*Once again, this is a typical "infile" macro that you don't need to understand;
%let _EFIERR_ = 0; /* set the ERROR detection macro variable */

*Now, we set the "infile" command. Here, we specify the path, the delimiter, DSD,
"missover", the row of the first observation, the logical record length, and that 
SAS should ignore spurious ending characters.;
infile "[FILE PATH]\SAS Training 2020\RawData\Dept. of Education Data.txt"
dlm = "|" DSD missover firstobs = 2 lrecl = 32767 ignoredoseof;

*Informat commands come first to tell SAS how to read the raw data. "$" indicates
a string, and the lack of a "$" indicates a numeric. Note the use of the "yymmdd8."
format as a date format for YYYY-MM-DD (get it? 8 characters). Additionally, note
the spacing to make this more readable. While not necessary, it is recommended that
you structure your SAS code with tabs as below so that you can quickly see/change
how you are setting data.;
informat fiscal_year 						:4.;
informat state		 						:$2.;
informat county				 				:$30.;
informat district_name 						:$45.;
informat instruction_expenditures			:8.;
informat local_revenue 						:8.;
informat state_revenue 						:8.;
informat federal_revenue 					:8.;
informat county_name			 			:$30.;
informat total_enrollment	 				:8.;
informat low_income_students	 			:8.;
informat total_male					 		:8.;
informat total_female			 			:8.;
informat total_white			 			:8.;
informat total_black			 			:8.;
informat total_american_indian	 			:8.;
informat total_hispanic						:8.;
informat total_grad_count					:8.;
informat total_cohort_count 				:8.;
informat per_pupil_expenditures		 		:8.;
informat cohort_instruction_expenditures	:8.;
informat total_asian			 			:8.;
informat total_multiracial			 		:8.;
informat total_females	 					:8.;
informat total_males						:8.;
informat state_name							:8.;
informat district_id 						:$30.;
informat total_cohort			 			:8.;
informat grad_rate			 				:8.;
informat ppe	 							:8.;
informat pp_local_rev						:8.;
informat pp_state_rev						:8.;
informat pp_fed_rev							:8.;

*Now, we format the financial variables in a manner in which we would like to view them.
Note that we do not format every variable (although we could) because SAS will auto
format all other variables. We don't necessarily need to format all of the
variables if we don't want to.;
format district_name 						$45.;
format instruction_expenditures				dollar16.2;
format local_revenue 						dollar16.2;
format state_revenue 						dollar16.2;
format federal_revenue 						dollar16.2;

*Finally, input your data into a SAS dataset. Here, we specify every string variable
with a "$" (you could specify the dollar sign followed by a number, but then SAS
will expect that every observation should have that length). Numeric variables are not
followed by any specification, but you could once again specify a number of digits
that should be input. The date and financial variables are also input as numerics here 
and they will be formatted according to our "format" command above.;
input 
	fiscal_year
	state $
	county $
	district_name $
	instruction_expenditures
	local_revenue
	state_revenue
	federal_revenue
	county_name $
	total_enrollment
	low_income_students
	total_male
	total_female
	total_white
	total_black
	total_american_indian
	total_hispanic
	total_grad_count
	total_cohort_count
	per_pupil_expenditures
	cohort_instruction_expenditures
	total_asian
	total_multiracial
	total_paid_meals
	total_females
	total_males
	state_name $
	district_id $
	total_cohort
	grad_rate
	ppe
	pp_local_rev
	pp_state_rev
	pp_fed_rev
	;

run;
