*************************
*************************
*****SAS LESSON FIVE*****
*************************
*************************;

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
*Congratulations on making it this far in the SAS trainings! At this point, you have
all of the basics down, as well as some of the advanced stuff. You can import all kinds
of data, create and drop observations and variables, sort, aggregate, merge, and reshape.
You might think that this is everything, and you're almost right. Technically, this lesson
won't teach you how to do anything that you don't know how to do, but it will be entirely
devoted to proc sql.;

*SQL, short for "Structured Query Language", is a programming language created entirely
for the purpose of manipulating data. Pronounced either "sequel" or by its initials
"SQL", you cannot run regressions or make visuals in SQL. SQL is only useful for
subsetting and merging data, and occasionally for creating or dropping variables or
observations. The thing is, SQL is REALLY good for those things. Particularly when you
are working with big data, SQL is fast, easy to write, and it can quickly configure
big data into a workable size.;

*SQL is its own programming language and you can take on the SQL training anytime you want.
However, many data tools including R and SAS allow you to run SQL queries directly from
their interfaces. (Get it? SQL is a "query" language. You can't run programs through it,
only queries. In this way, every SQL command is referred to as a query.) In SAS, SQL is so
well integrated that most SAS programmers will use a combination of proc steps, data steps,
and SQL queries whenever they use SAS. As you work with it, you will likely find that SQL's
syntax is in fact more intuitive than SAS's syntax, and it is extremely fast.;

*Notably, SQL programmers typically refer to R SQL or SAS SQL as "flavors of SQL". 90%
of the code you learn in this lesson is directly translateable to SQL, but 10% is SAS
specific to this version of SQL. Additionally, there are many things that pure SQL can
do that SAS SQL cannot do, and it's important to keep that in mind. If you go looking
for help on any of these topics, make sure that you research the SAS SQL syntax, as it
may be slightly different from the pure SQL syntax or the R SQL syntax (or the ArcGIS
SQL syntax or the Python SQL syntax or the Access SQL syntax or any other SQL syntax).;


*********************
***GETTING STARTED***
*********************;
*Before we do any work in SQL, we need to import some data. Note that SQL cannot import
data - you must import it into a database (or in this case, into your library), prior
to doing any manipulations.;
data work.insur_xlsx;
	retain State_Code
			County_Name
			Metal_Level
			Issuer_Name
			Plan_ID__Standard_Component_
			Plan_Marketing_Name
			Plan_Type
			Rating_Area
			Child_Only_Offering
			Source
			Customer_Service_Phone_Number_Lo
			Customer_Service_Phone_Number_To
			Customer_Service_Phone_Number_TT
			Network_URL
			Plan_Brochure_URL
			Summary_of_Benefits_URL
			Drug_Formulary_URL
			Accredidation
			Adult_Dental
			Child_Dental
			EHB_Percent_of_Total_Premium
			Premium_Scenarios
			Premium_Child
			Premium_Adult_Individual_Age_21
			Premium_Adult_Individual_Age_27
			Premium_Adult_Individual_Age_30
			Premium_Adult_Individual_Age_40
			Premium_Adult_Individual_Age_50
			Premium_Adult_Individual_Age_60
			Premium_Couple_21
			Premium_Couple_30
			Premium_Couple_40
			Premium_Couple_50
			Premium_Couple_60
			Couple_1_child__Age_21
			Couple_1_child__Age_30
			Couple_1_child__Age_40
			Couple_1_child__Age_50
			Couple_2_children_Age_21
			Couple_2_children_Age_30
			Couple_2_children_Age_40
			Couple_2_children_Age_50
			Couple_3_or_more_Children__Age_2
			Couple_3_or_more_Children__Age_3
			Couple_3_or_more_Children__Age_4
			Couple_3_or_more_Children__Age_5
			Individual_1_child__Age_21
			Individual_1_child__Age_30
			Individual_1_child__Age_40
			Individual_1_child__Age_50
			Individual_2_child__Age_21
			Individual_2_child__Age_30
			Individual_2_child__Age_40
			Individual_2_child__Age_50
			Individual_3_or_more_children__A
			Individual_3_or_more_children__0
			Individual_3_or_more_children__1
			Individual_3_or_more_children__2
			Standard_Plan_Cost_Sharing
			Medical_Deductible__Individual_
			Drug_Deductible__Individual__S
			Medical_Deductible__Family__St
			Drug_Deductible__Family_Stand
			Medical_Deductible__Family__Per
			Drug_Deductible__Family__Per_Pe
			Medical_Maximum_Out_Of_Pocket__
			Drug_Maximum_Out_Of_Pocket__Ind
			Medical_Maximum_Out_Of_Pocket__0
			Drug_Maximum_Out_Of_Pocket__Fam
			Medical_Maximum_Out_Of_Pocket__1
			Drug_Maximum_Out_Of_Pocket__Fa0
			Primary_Care_Physician___Standar
			Specialist__Standard
			Emergency_Room__Standard
			Inpatient_Facility__Standard
			Inpatient_Physician__Standard
			Generic_Drugs__Standard
			Preferred_Brand_Drugs__Standard
			Non_preferred_Brand_Drugs__Stan
			Specialty_Drugs__Standard
			_3_Percent_Actuarial_Value_Silve
			Medical_Deductible_Individual_0
			Drug_Deductible__Individual__7
			Medical_Deductible_Individual_73
			Drug_Deductible__Family__73
			Medical_Deductible__Family__Pe0
			Drug_Deductible__Family__Per_P0
			Medical_Maximum_Out_Of_Pocket__2
			Drug_Maximum_Out_Of_Pocket__In0
			Medical_Maximum_Out_Of_Pocket__3
			Drug_Maximum_Out_Of_Pocket__Fa1
			Medical_Maximum_Out_Of_Pocket__4
			Drug_Maximum_Out_Of_Pocket__Fa2
			Primary_Care_Physician__73_Perc
			Specialist__73_Percent
			Emergency_Room__73_Percent
			Inpatient_Facility__73_Percent
			Inpatient_Physician__73_Percent
			Generic_Drugs__73_Percent
			Preferred_Brand_Drugs__73_Perce
			Non_preferred_Brand_Drugs__73_P
			Specialty_Drugs__73_Percent
			_7_Percent_Actuarial_Value_Silve
			Medical_Deductible__Individual1
			Drug_Deductible__Individual__8
			Medical_Deductible__Family__87
			Drug_Deductible_Ind_87_Pe
			Medical_Deductible__Family__Pe1
			Drug_Deductible__Family__Per_P1
			Medical_Maximum_Out_Of_Pocket__5
			Drug_Maximum_Out_Of_Pocket__In1
			Medical_Maximum_Out_Of_Pocket__6
			Drug_Maximum_Out_Of_Pocket__Fa3
			Medical_Maximum_Out_Of_Pocket__7
			Drug_Maximum_Out_Of_Pocket__Fa4
			Primary_Care_Physician__87_Perc
			Specialist__87_Percent
			Emergency_Room__87_Percent
			Inpatient_Facility__87_Percent
			Inpatient_Physician__87_Percent
			Generic_Drugs__87_Percent
			Preferred_Brand_Drugs__87_Perce
			Non_preferred_Brand_Drugs__87_P
			Specialty_Drugs__87_Percent
			_4_Percent_Actuarial_Value_Silve
			Medical_Deductible_Individual2
			Drug_Deductible__Individual__9
			Medical_Deductible__Family__94
			Drug_Deductible__Family__94_Pe
			Medical_Deductible__Family__Pe2
			Drug_Deductible__Family__Per_P2
			Medical_Maximum_Out_Of_Pocket__i
			Drug_Maximum_Out_Of_Pocket__in2
			Medical_Maximum_Out_Of_Pocket__8
			Drug_Maximum_Out_Of_Pocket__Fa5
			Medical_Maximum_Out_Of_Pocket__9
			Drug_Maximum_Out_Of_Pocket__Fa6
			Primary_Care_Physician__94_Perc
			Specialist__94_Percent
			Emergency_Room__94_Percent
			Inpatient_Facility__94_Percent
			Inpatient_Physician__94_Percent
			Generic_Drugs__94_Percent
			Preferred_Brand_Drugs__94_Perce
			Non_preferred_Brand_Drugs__94_P
			Specialty_Drugs__94_Percent
			;

infile "&raw\2-2016_QHP_Landscape_Individual_Market_Medical - Data_AK-MT.csv"
dlm = "," DSD missover firstobs = 2 length = reclen;

	informat State_Code 								:$2.;
	informat County_Name 								:$14.;
	informat Metal_Level 								:$12.;
	informat Issuer_Name 								:$40.;
	informat Plan_ID__Standard_Component_ 				:$14.;
	informat Plan_Marketing_Name 						:$63.;
	informat Plan_Type 									:$3.;
	informat Rating_Area 								:$13.;
	informat Child_Only_Offering 						:$27.;
	informat Source 									:$4.;
	informat Customer_Service_Phone_Number_Lo 			:$14.;
	informat Customer_Service_Phone_Number_To 			:$14.;
	informat Customer_Service_Phone_Number_TT 			:$14.;
	informat Network_URL 								:$67.;
	informat Plan_Brochure_URL 							:$90.;
	informat Summary_of_Benefits_URL 					:$94.;
	informat Drug_Formulary_URL 						:$68.;
	informat Accredidation 								:$4.;
	informat Adult_Dental 								:$1.;
	informat Child_Dental 								:$1.;
	informat EHB_Percent_of_Total_Premium 				:$6.;
	informat Premium_Scenarios 							:$1.;
	informat Premium_Child 								:comma.;
	informat Premium_Adult_Individual_Age_21 			:comma.;
	informat Premium_Adult_Individual_Age_27 			:$32.;
	informat Premium_Adult_Individual_Age_30 			:$32.;
	informat Premium_Adult_Individual_Age_40 			:$12.;
	informat Premium_Adult_Individual_Age_50 			:$12.;
	informat Premium_Adult_Individual_Age_60 			:$12.;
	informat Premium_Couple_21 							:$12.;
	informat Premium_Couple_30 							:$12.;
	informat Premium_Couple_40 							:$12.;
	informat Premium_Couple_50 							:$12.;
	informat Premium_Couple_60 							:$12.;
	informat Couple_1_child__Age_21 					:$12.;
	informat Couple_1_child__Age_30 					:$12.;
	informat Couple_1_child__Age_40 					:$12.;
	informat Couple_1_child__Age_50 					:$12.;
	informat Couple_2_children_Age_21 					:$12.;
	informat Couple_2_children_Age_30 					:$12.;
	informat Couple_2_children_Age_40 					:$12.;
	informat Couple_2_children_Age_50 					:$12.;
	informat Couple_3_or_more_Children__Age_2 			:$12.;
	informat Couple_3_or_more_Children__Age_3 			:$12.;
	informat Couple_3_or_more_Children__Age_4 			:$12.;
	informat Couple_3_or_more_Children__Age_5 			:$12.;
	informat Individual_1_child__Age_21 				:$12.;
	informat Individual_1_child__Age_30 				:$12.;
	informat Individual_1_child__Age_40 				:$12.;
	informat Individual_1_child__Age_50 				:$12.;
	informat Individual_2_child__Age_21 				:$12.;
	informat Individual_2_child__Age_30 				:$12.;
	informat Individual_2_child__Age_40 				:$12.;
	informat Individual_2_child__Age_50 				:$12.;
	informat Individual_3_or_more_children__A 			:$12.;
	informat Individual_3_or_more_children__0 			:$12.;
	informat Individual_3_or_more_children__1 			:$12.;
	informat Individual_3_or_more_children__2 			:$12.;
	informat Standard_Plan_Cost_Sharing 				:$1.;
	informat Medical_Deductible__Individual_ 			:$9.;
	informat Drug_Deductible__Individual__S 			:$19.;
	informat Medical_Deductible__Family__St 			:$10.;
	informat Drug_Deductible__Family_Stand 				:$19.;
	informat Medical_Deductible__Family__Per 			:$10.;
	informat Drug_Deductible__Family__Per_Pe 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__ 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Ind 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__0 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Fam 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__1 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Fa0 			:$19.;
	informat Primary_Care_Physician___Standar 			:$32.;
	informat Specialist__Standard 						:$32.;
	informat Emergency_Room__Standard 					:$32.;
	informat Inpatient_Facility__Standard 				:$32.;
	informat Inpatient_Physician__Standard 				:$32.;
	informat Generic_Drugs__Standard 					:$32.;
	informat Preferred_Brand_Drugs__Standard 			:$32.;
	informat Non_preferred_Brand_Drugs__Stan 			:$32.;
	informat Specialty_Drugs__Standard 					:$32.;
	informat _3_Percent_Actuarial_Value_Silve 			:$1.;
	informat Medical_Deductible_Individual_0 			:$10.;
	informat Drug_Deductible__Individual__7 			:$19.;
	informat Medical_Deductible_Individual_73 			:$10.;
	informat Drug_Deductible__Family__73 				:$19.;
	informat Medical_Deductible__Family__Pe0 			:$10.;
	informat Drug_Deductible__Family__Per_P0 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__2 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__In0 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__3 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Fa1 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__4 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Fa2 			:$19.;
	informat Primary_Care_Physician__73_Perc 			:$32.;
	informat Specialist__73_Percent 					:$32.;
	informat Emergency_Room__73_Percent 				:$32.;
	informat Inpatient_Facility__73_Percent 			:$32.;
	informat Inpatient_Physician__73_Percent 			:$32.;
	informat Generic_Drugs__73_Percent 					:$32.;
	informat Preferred_Brand_Drugs__73_Perce 			:$32.;
	informat Non_preferred_Brand_Drugs__73_P 			:$32.;
	informat Specialty_Drugs__73_Percent 				:$32.;
	informat _7_Percent_Actuarial_Value_Silve 			:$1.;
	informat Medical_Deductible__Individual1 			:$10.;
	informat Drug_Deductible__Individual__8 			:$19.;
	informat Medical_Deductible__Family__87 			:$10.;
	informat Drug_Deductible_Ind_87_Pe 					:$19.;
	informat Medical_Deductible__Family__Pe1 			:$10.;
	informat Drug_Deductible__Family__Per_P1 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__5 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__In1 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__6 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Fa3 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__7 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Fa4 			:$19.;
	informat Primary_Care_Physician__87_Perc 			:$32.;
	informat Specialist__87_Percent 					:$32.;
	informat Emergency_Room__87_Percent 				:$32.;
	informat Inpatient_Facility__87_Percent 			:$32.;
	informat Inpatient_Physician__87_Percent 			:$32.;
	informat Generic_Drugs__87_Percent 					:$32.;
	informat Preferred_Brand_Drugs__87_Perce 			:$32.;
	informat Non_preferred_Brand_Drugs__87_P 			:$32.;
	informat Specialty_Drugs__87_Percent 				:$32.;
	informat _4_Percent_Actuarial_Value_Silve 			:$1.;
	informat Medical_Deductible_Individual2 			:$32.;
	informat Drug_Deductible__Individual__9 			:$19.;
	informat Medical_Deductible__Family__94 			:$32.;
	informat Drug_Deductible__Family__94_Pe 			:$19.;
	informat Medical_Deductible__Family__Pe2 			:$32.;
	informat Drug_Deductible__Family__Per_P2 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__i 			:32.;
	informat Drug_Maximum_Out_Of_Pocket__in2 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__8 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Fa5 			:$19.;
	informat Medical_Maximum_Out_Of_Pocket__9 			:$10.;
	informat Drug_Maximum_Out_Of_Pocket__Fa6 			:$19.;
	informat Primary_Care_Physician__94_Perc 			:$32.;
	informat Specialist__94_Percent 					:$32.;
	informat Emergency_Room__94_Percent 				:$32.;
	informat Inpatient_Facility__94_Percent 			:$32.;
	informat Inpatient_Physician__94_Percent 			:$32.;
	informat Generic_Drugs__94_Percent 					:$32.;
	informat Preferred_Brand_Drugs__94_Perce 			:$32.;
	informat Non_preferred_Brand_Drugs__94_P 			:$32.;
	informat Specialty_Drugs__94_Percent 				:$32.;

	format State_Code 									$2.;
	format County_Name 									$14.;
	format Metal_Level 									$12.;
	format Issuer_Name 									$40.;
	format Plan_ID__Standard_Component_ 				$14.;
	format Plan_Marketing_Name 							$63.;
	format Plan_Type 									$3.;
	format Rating_Area 									$13.;
	format Child_Only_Offering 							$27.;
	format Source 										$4.;
	format Customer_Service_Phone_Number_Lo 			$14.;
	format Customer_Service_Phone_Number_To 			$14.;
	format Customer_Service_Phone_Number_TT 			$14.;
	format Network_URL 									$67.;
	format Plan_Brochure_URL 							$90.;
	format Summary_of_Benefits_URL 						$94.;
	format Drug_Formulary_URL 							$68.;
	format Accredidation 								$4.;
	format Adult_Dental 								$1.;
	format Child_Dental 								$1.;
	format EHB_Percent_of_Total_Premium 				$6.;
	format Premium_Scenarios 							$1.;
	format Premium_Child 								8.;
	format Premium_Adult_Individual_Age_21 				8.;
	format Premium_Adult_Individual_Age_27 				$32.;
	format Premium_Adult_Individual_Age_30 				$32.;
	format Premium_Adult_Individual_Age_40 				$12.;
	format Premium_Adult_Individual_Age_50 				$12.;
	format Premium_Adult_Individual_Age_60 				$12.;
	format Premium_Couple_21 							$12.;
	format Premium_Couple_30 							$12.;
	format Premium_Couple_40 							$12.;
	format Premium_Couple_50 							$12.;
	format Premium_Couple_60 							$12.;
	format Couple_1_child__Age_21 						$12.;
	format Couple_1_child__Age_30 						$12.;
	format Couple_1_child__Age_40 						$12.;
	format Couple_1_child__Age_50 						$12.;
	format Couple_2_children_Age_21 					$12.;
	format Couple_2_children_Age_30 					$12.;
	format Couple_2_children_Age_40 					$12.;
	format Couple_2_children_Age_50 					$12.;
	format Couple_3_or_more_Children__Age_2 			$12.;
	format Couple_3_or_more_Children__Age_3 			$12.;
	format Couple_3_or_more_Children__Age_4 			$12.;
	format Couple_3_or_more_Children__Age_5 			$12.;
	format Individual_1_child__Age_21 					$12.;
	format Individual_1_child__Age_30 					$12.;
	format Individual_1_child__Age_40 					$12.;
	format Individual_1_child__Age_50 					$12.;
	format Individual_2_child__Age_21 					$12.;
	format Individual_2_child__Age_30 					$12.;
	format Individual_2_child__Age_40 					$12.;
	format Individual_2_child__Age_50 					$12.;
	format Individual_3_or_more_children__A 			$12.;
	format Individual_3_or_more_children__0 			$12.;
	format Individual_3_or_more_children__1 			$12.;
	format Individual_3_or_more_children__2 			$12.;
	format Standard_Plan_Cost_Sharing 					$1.;
	format Medical_Deductible__Individual_ 				$9.;
	format Drug_Deductible__Individual__S 				$19.;
	format Medical_Deductible__Family__St 				$10.;
	format Drug_Deductible__Family_Stand 				$19.;
	format Medical_Deductible__Family__Per 				$10.;
	format Drug_Deductible__Family__Per_Pe 				$19.;
	format Medical_Maximum_Out_Of_Pocket__ 				$10.;
	format Drug_Maximum_Out_Of_Pocket__Ind 				$19.;
	format Medical_Maximum_Out_Of_Pocket__0 			$10.;
	format Drug_Maximum_Out_Of_Pocket__Fam 				$19.;
	format Medical_Maximum_Out_Of_Pocket__1 			$10.;
	format Drug_Maximum_Out_Of_Pocket__Fa0 				$19.;
	format Primary_Care_Physician___Standar 			$32.;
	format Specialist__Standard 						$32.;
	format Emergency_Room__Standard 					$32.;
	format Inpatient_Facility__Standard 				$32.;
	format Inpatient_Physician__Standard 				$32.;
	format Generic_Drugs__Standard 						$32.;
	format Preferred_Brand_Drugs__Standard 				$32.;
	format Non_preferred_Brand_Drugs__Stan 				$32.;
	format Specialty_Drugs__Standard 					$32.;
	format _3_Percent_Actuarial_Value_Silve 			$1.;
	format Medical_Deductible_Individual_0 				$10.;
	format Drug_Deductible__Individual__7 				$19.;
	format Medical_Deductible_Individual_73 			$10.;
	format Drug_Deductible__Family__73 					$19.;
	format Medical_Deductible__Family__Pe0 				$10.;
	format Drug_Deductible__Family__Per_P0 				$19.;
	format Medical_Maximum_Out_Of_Pocket__2 			$10.;
	format Drug_Maximum_Out_Of_Pocket__In0 				$19.;
	format Medical_Maximum_Out_Of_Pocket__3 			$10.;
	format Drug_Maximum_Out_Of_Pocket__Fa1 				$19.;
	format Medical_Maximum_Out_Of_Pocket__4 			$10.;
	format Drug_Maximum_Out_Of_Pocket__Fa2 				$19.;
	format Primary_Care_Physician__73_Perc 				$32.;
	format Specialist__73_Percent 						$32.;
	format Emergency_Room__73_Percent 					$32.;
	format Inpatient_Facility__73_Percent 				$32.;
	format Inpatient_Physician__73_Percent 				$32.;
	format Generic_Drugs__73_Percent 					$32.;
	format Preferred_Brand_Drugs__73_Perce 				$32.;
	format Non_preferred_Brand_Drugs__73_P 				$32.;
	format Specialty_Drugs__73_Percent 					$32.;
	format _7_Percent_Actuarial_Value_Silve 			$1.;
	format Medical_Deductible__Individual1 				$10.;
	format Drug_Deductible__Individual__8 				$19.;
	format Medical_Deductible__Family__87 				$10.;
	format Drug_Deductible_Ind_87_Pe 					$19.;
	format Medical_Deductible__Family__Pe1 				$10.;
	format Drug_Deductible__Family__Per_P1 				$19.;
	format Medical_Maximum_Out_Of_Pocket__5 			$10.;
	format Drug_Maximum_Out_Of_Pocket__In1 				$19.;
	format Medical_Maximum_Out_Of_Pocket__6 			$10.;
	format Drug_Maximum_Out_Of_Pocket__Fa3 				$19.;
	format Medical_Maximum_Out_Of_Pocket__7 			$10.;
	format Drug_Maximum_Out_Of_Pocket__Fa4 				$19.;
	format Primary_Care_Physician__87_Perc 				$32.;
	format Specialist__87_Percent 						$32.;
	format Emergency_Room__87_Percent 					$32.;
	format Inpatient_Facility__87_Percent 				$32.;
	format Inpatient_Physician__87_Percent 				$32.;
	format Generic_Drugs__87_Percent 					$32.;
	format Preferred_Brand_Drugs__87_Perce 				$32.;
	format Non_preferred_Brand_Drugs__87_P 				$32.;
	format Specialty_Drugs__87_Percent 					$32.;
	format _4_Percent_Actuarial_Value_Silve 			$1.;
	format Medical_Deductible_Individual2 				$32.;
	format Drug_Deductible__Individual__9 				$19.;
	format Medical_Deductible__Family__94 				$32.;
	format Drug_Deductible__Family__94_Pe 				$19.;
	format Medical_Deductible__Family__Pe2 				$32.;
	format Drug_Deductible__Family__Per_P2 				$19.;
	format Medical_Maximum_Out_Of_Pocket__i 			32.;
	format Drug_Maximum_Out_Of_Pocket__in2 				$19.;
	format Medical_Maximum_Out_Of_Pocket__8 			$10.;
	format Drug_Maximum_Out_Of_Pocket__Fa5 				$19.;
	format Medical_Maximum_Out_Of_Pocket__9 			$10.;
	format Drug_Maximum_Out_Of_Pocket__Fa6 				$19.;
	format Primary_Care_Physician__94_Perc 				$32.;
	format Specialist__94_Percent 						$32.;
	format Emergency_Room__94_Percent 					$32.;
	format Inpatient_Facility__94_Percent 				$32.;
	format Inpatient_Physician__94_Percent 				$32.;
	format Generic_Drugs__94_Percent 					$32.;
	format Preferred_Brand_Drugs__94_Perce 				$32.;
	format Non_preferred_Brand_Drugs__94_P 				$32.;
	format Specialty_Drugs__94_Percent 					$32.;

input 
	State_Code $
	County_Name $
	Metal_Level $
	Issuer_Name $
	Plan_ID__Standard_Component_ $
	Plan_Marketing_Name $
	Plan_Type $
	Rating_Area $
	Child_Only_Offering $
	Source $
	Customer_Service_Phone_Number_Lo $
	Customer_Service_Phone_Number_To $
	Customer_Service_Phone_Number_TT $
	Network_URL $
	Plan_Brochure_URL $
	Summary_of_Benefits_URL $
	Drug_Formulary_URL $
	Accredidation $
	Adult_Dental $
	Child_Dental $
	EHB_Percent_of_Total_Premium $
	Premium_Scenarios $
	Premium_Child
	Premium_Adult_Individual_Age_21
	Premium_Adult_Individual_Age_27 $
	Premium_Adult_Individual_Age_30 $
	Premium_Adult_Individual_Age_40 $
	Premium_Adult_Individual_Age_50 $
	Premium_Adult_Individual_Age_60 $
	Premium_Couple_21 $
	Premium_Couple_30 $
	Premium_Couple_40 $
	Premium_Couple_50 $
	Premium_Couple_60 $
	Couple_1_child__Age_21 $
	Couple_1_child__Age_30 $
	Couple_1_child__Age_40 $
	Couple_1_child__Age_50 $
	Couple_2_children_Age_21 $
	Couple_2_children_Age_30 $
	Couple_2_children_Age_40 $
	Couple_2_children_Age_50 $
	Couple_3_or_more_Children__Age_2 $
	Couple_3_or_more_Children__Age_3 $
	Couple_3_or_more_Children__Age_4 $
	Couple_3_or_more_Children__Age_5 $
	Individual_1_child__Age_21 $
	Individual_1_child__Age_30 $
	Individual_1_child__Age_40 $
	Individual_1_child__Age_50 $
	Individual_2_child__Age_21 $
	Individual_2_child__Age_30 $
	Individual_2_child__Age_40 $
	Individual_2_child__Age_50 $
	Individual_3_or_more_children__A $
	Individual_3_or_more_children__0 $
	Individual_3_or_more_children__1 $
	Individual_3_or_more_children__2 $
	Standard_Plan_Cost_Sharing $
	Medical_Deductible__Individual_ $
	Drug_Deductible__Individual__S $
	Medical_Deductible__Family__St $
	Drug_Deductible__Family_Stand $
	Medical_Deductible__Family__Per $
	Drug_Deductible__Family__Per_Pe $
	Medical_Maximum_Out_Of_Pocket__ $
	Drug_Maximum_Out_Of_Pocket__Ind $
	Medical_Maximum_Out_Of_Pocket__0 $
	Drug_Maximum_Out_Of_Pocket__Fam $
	Medical_Maximum_Out_Of_Pocket__1 $
	Drug_Maximum_Out_Of_Pocket__Fa0 $
	Primary_Care_Physician___Standar $
	Specialist__Standard $
	Emergency_Room__Standard $
	Inpatient_Facility__Standard $
	Inpatient_Physician__Standard $
	Generic_Drugs__Standard $
	Preferred_Brand_Drugs__Standard $
	Non_preferred_Brand_Drugs__Stan $
	Specialty_Drugs__Standard $
	_3_Percent_Actuarial_Value_Silve $
	Medical_Deductible_Individual_0 $
	Drug_Deductible__Individual__7 $
	Medical_Deductible_Individual_73 $
	Drug_Deductible__Family__73 $
	Medical_Deductible__Family__Pe0 $
	Drug_Deductible__Family__Per_P0 $
	Medical_Maximum_Out_Of_Pocket__2 $
	Drug_Maximum_Out_Of_Pocket__In0 $
	Medical_Maximum_Out_Of_Pocket__3 $
	Drug_Maximum_Out_Of_Pocket__Fa1 $
	Medical_Maximum_Out_Of_Pocket__4 $
	Drug_Maximum_Out_Of_Pocket__Fa2 $
	Primary_Care_Physician__73_Perc $
	Specialist__73_Percent $
	Emergency_Room__73_Percent $
	Inpatient_Facility__73_Percent $
	Inpatient_Physician__73_Percent $
	Generic_Drugs__73_Percent $
	Preferred_Brand_Drugs__73_Perce $
	Non_preferred_Brand_Drugs__73_P $
	Specialty_Drugs__73_Percent $
	_7_Percent_Actuarial_Value_Silve $
	Medical_Deductible__Individual1 $
	Drug_Deductible__Individual__8 $
	Medical_Deductible__Family__87 $
	Drug_Deductible_Ind_87_Pe $
	Medical_Deductible__Family__Pe1 $
	Drug_Deductible__Family__Per_P1 $
	Medical_Maximum_Out_Of_Pocket__5 $
	Drug_Maximum_Out_Of_Pocket__In1 $
	Medical_Maximum_Out_Of_Pocket__6 $
	Drug_Maximum_Out_Of_Pocket__Fa3 $
	Medical_Maximum_Out_Of_Pocket__7 $
	Drug_Maximum_Out_Of_Pocket__Fa4 $
	Primary_Care_Physician__87_Perc $
	Specialist__87_Percent $
	Emergency_Room__87_Percent $
	Inpatient_Facility__87_Percent $
	Inpatient_Physician__87_Percent $
	Generic_Drugs__87_Percent $
	Preferred_Brand_Drugs__87_Perce $
	Non_preferred_Brand_Drugs__87_P $
	Specialty_Drugs__87_Percent $
	_4_Percent_Actuarial_Value_Silve $
	Medical_Deductible_Individual2 $
	Drug_Deductible__Individual__9 $
	Medical_Deductible__Family__94 $
	Drug_Deductible__Family__94_Pe $
	Medical_Deductible__Family__Pe2 $
	Drug_Deductible__Family__Per_P2 $
	Medical_Maximum_Out_Of_Pocket__i 
	Drug_Maximum_Out_Of_Pocket__in2 $
	Medical_Maximum_Out_Of_Pocket__8 $
	Drug_Maximum_Out_Of_Pocket__Fa5 $
	Medical_Maximum_Out_Of_Pocket__9 $
	Drug_Maximum_Out_Of_Pocket__Fa6 $
	Primary_Care_Physician__94_Perc $
	Specialist__94_Percent $
	Emergency_Room__94_Percent $
	Inpatient_Facility__94_Percent $
	Inpatient_Physician__94_Percent $
	Generic_Drugs__94_Percent $
	Preferred_Brand_Drugs__94_Perce $
	Non_preferred_Brand_Drugs__94_P $
	Specialty_Drugs__94_Percent $
	;

run;

*Remove all labels in data. These supercede the variable names in the columns, so it is
confusing to look at these if they are not the same as the variable names. This is a
standard proc datasets command to modify work.insur_xlsx;
proc datasets library = work nolist;
   modify insur_xlsx;
     attrib _all_ label = "";
run;
quit;

*Any SQL query you run in SAS begins with the proc sql statement. Anything between
"proc sql" and "quit" will be interpreted as SQL code instead of SAS commands.
Additionally, any SQL query that you will run will have the following formatting:;
proc sql;
	create table work.insurance_sql_table1 as
	select *

	from work.insur_xlsx;
quit;

*Let's break down these three lines:

***create table: This first line is "creating" your output. This is to say that you 
	are creating a data table with the following specifications. 

***select: here, you "select" the columns that you want to pull from the raw dataset. 
	This speaks to the fact that SQL is intended to work with big datasets. If you are 
	working with hundreds or thousands of columns, the very first thing you'll want to 
	do is keep only the columns you want to see. The use of the asterisk here selects
	all of the columns. 

***from: the last line is a "from" statement, and it specifies the
	target dataset from which you will select your columns and create your data table.;

*While this isn't very big data, let's work with one of our small datasets to
demonstrate how to do a SQL query. Here, we just select the columns we want from
the dataset.;
proc sql;
	create table work.insurance_sql_table2 as
	select State_Code
	, County_Name
	, Metal_Level
	, Issuer_Name
	, Plan_Type
	, Source
 
	from work.insur_xlsx;
quit;

*This second table only contains the five variables we specified, those being State_Code,
County_Name, Metal_Level, Issuer_Name, Plan_Type, and Source.


***********************
***MANIPULATING DATA***
***********************;
*As you may have already surmised, keeping and dropping variables is extremely easy
in SQL. You simply include or exclude variables in your "select" statement, and
those variables will be in your output. In the following example, we drop the Source
variable, just by not including it in the select statement:;

proc sql;
	create table work.insurance_sql_table3 as
	select State_Code
	, County_Name
	, Metal_Level
	, Issuer_Name
	, Plan_Type
 
	from work.insur_xlsx;
quit;

*Additionally, we can create variables. This is just as straightforward as dropping
variables, and it uses the "as" syntax. We just need to add a line in the select
statement to include a new variable in the output. In the following example, we create
a new variable entitled Country that is equal to "USA", by adding a line to set a value
AS the new variable:;
proc sql;
	create table work.insurance_sql_table4 as
	select State_Code
	, County_Name
	, Metal_Level
	, Issuer_Name
	, Plan_Type
	, "USA" as Country
 
	from work.insur_xlsx;
quit;

*We can also rename variables in the select statement using the AS syntax. In the following
example, we rename Issuer_Name to Insurer:;
proc sql;
	create table work.insurance_sql_table4 as
	select State_Code
	, County_Name
	, Metal_Level
	, Issuer_Name as Insurer
	, Plan_Type
	, "USA" as Country
 
	from work.insur_xlsx;
quit;

*SQL uses "case when" syntax to conditionally create variables. This is very straightforward.
The syntax is case when <condition> then <result>. In the following example, we create
a numeric ranking for the Metal Level using a case command;
proc sql;
	create table work.insurance_sql_table5 as
	select State_Code
	, County_Name
	, Metal_Level
	, Issuer_Name as Insurer
	, Plan_Type
	, "USA" as Country
	, case when Metal_Level = "Gold" then 1
		when Metal_Level = "Silver" then 2
		when Metal_Level = "Bronze" then 3
		else 0 end as Metal_Ranking
 
	from work.insur_xlsx;
quit;

*Note that we used multiple "when"-"then" clauses, and the case statment ends with the word
"end". Following this, we have the normal syntax to assign a new variable AS Metal_Ranking.;

*We can drop observations using the "where" syntax. This is typically after the from
statement. In the following example, we only keep observations in which the Plan_Type
is "PPO";
proc sql;
	create table work.insurance_sql_table6 as
	select State_Code
	, County_Name
	, Metal_Level
	, Issuer_Name as Insurer
	, Plan_Type
	, "USA" as Country
	, case when Metal_Level = "Gold" then 1
		when Metal_Level = "Silver" then 2
		when Metal_Level = "Bronze" then 3
		else 0 end as Metal_Ranking
 
	from work.insur_xlsx

	where Plan_Type = "PPO";
quit;


***********************
***NESTED STATEMENTS***
***********************;
*Moving on from the basic SQL syntax of creating tables, it is important to understand
the nested structure of SQL. SQL is best understood "inside to outside." That is to say
that SQL frequently uses internal clauses, and the external clause is just the last
step in the process. In the following example, we use a nested from clause. We do
all of the cleaning, renaming, and variable creation in the internal clause,
and then the external clause just sets the variable names and order. Note that the
nested clause is enclosed in parentheses, and the "where" statement is in the same
location outside of the parentheses.;
proc sql;
	create table work.insurance_sql_table7 as
	select State
	, County
	, Metal_Level
	, Insurer
	, Plan_Type
	, Country
	, Metal_Ranking

	from (
		select State_Code as State
		, County_Name as County
		, Metal_Level
		, Issuer_Name as Insurer
		, Plan_Type
		, "USA" as Country
		, case when Metal_Level = "Gold" then 1
		when Metal_Level = "Silver" then 2
		when Metal_Level = "Bronze" then 3
		else 0 end as Metal_Ranking
 
	from work.insur_xlsx)

	where Plan_Type = "PPO";
quit;

*In the statement above, we renamed State_Code as State and Issuer_Name as Issuer. In
the outer select statement, we select the variables by their new names. Note that
the nested from statement is very similar to the queries we ran above, and now we've just
put it into an inner parentheses.;

*In addition to nesting statements, we can also nest functions. SQL can run as many
functions as you want within other functions. In the following example, we take the first
three characters of the Plan_ID__Standard_Component_ and convert them to numerics:;
proc sql;
	create table work.insurance_sql_table8 as
	select State
	, County
	, Metal_Level
	, Insurer
	, Plan_Type
	, Country
	, Metal_Ranking
	, Plan_ID

	from (
		select State_Code as State
		, County_Name as County
		, Metal_Level
		, Issuer_Name as Insurer
		, Plan_Type
		, "USA" as Country

		, case when Metal_Level = "Gold" then 1
		when Metal_Level = "Silver" then 2
		when Metal_Level = "Bronze" then 3
		else 0 end as Metal_Ranking

		, input(substr(Plan_ID__Standard_Component_, 1, 3), 3.) as Plan_ID
 
	from work.insur_xlsx)

	where Plan_Type = "PPO";
quit;


***********
***JOINS***
***********;
*Another useful feature of SQL is merging. In SQL, merges are referred to as "joins," and
they are slightly different from regular merges. You are likely familiar with a one to
one merge, a many to one merge, and a one to many merge. SQL doesn't do any of these
merges. SQL only does what are called "cartesian product" merges. This is a very
interesting merge as the number of observations will be equal to the product of the
merging observations.;

*For example. If you had a dataset titled "Data1" with five observations with IDs 1, 2, 3, 
4, and 5, you could merge this one to one with another dataset titled "Data2" that had 
exactly three observations with unique IDs 1, 2, and 6. The resulting merged dataset would
have 6 observations with unique IDs 1, 2, 3, 4, 5, and 6. Now, say that "Data2" has four
observations with unique IDs 1, 1, 2, and 6. Your second dataset is no longer unique in
terms of unique ID, so you could do a many to one merge with Data1. The resulting merged
dataset would have seven observations with unique IDs 1, 1, 2, 3, 4, 5, and 6.;

*Now, say your original dataset Data1 had six observations with unique IDs 1, 1, 2, 3, 4,
and 5, and your second dataset Data2 had four observations with unique IDs 1, 1, 2, and 6.
How would you merge these two datasets that are not unique in terms of ID? Your first
instinct might be a many to many merge or a collapse to get one dataset to be unique. If
you join these datasets in SQL however, your resulting dataset will have 9
observations. The unique IDs will be 1, 1, 1, 1, 2, 3, 4, 5, and 6. This is because you had
two merging observations on each side, namely 1 and 1. The Cartesian product of these is 4,
giving you 4 additional observations in your output.;

*In this way, a join in SQL will connect datasets in every way possible. You should be
careful - if you try to join two 10,000 observation datasets that have exactly the same
unique ID for all observations, your resulting dataset will have 100,000,000 (100 million)
observations. Still, this is extremely useful because you never need to worry about
datasets being unique in terms of an identifier, and you can immediately see every
combination of merging variables.;

*The syntax to set up a join is fairly straightforward. It comes just after the innermost
"from" statement, and once again, the dataset needs to be in your SAS library already.
Additionally, datasets in a join are typically shorthanded so that you can reference merging
variables by dataset. This is required when the two datasets have variables of the same
name, as in the following case, we merge on issuer_name from both datasets.;

*Import the dataset to merge:;
proc import datafile = "I:\Training\SAS Training\SAS Training 2020\IntermediateData\issuer_locations.csv"
	out = work.issuer_locations
	dbms = csv
	replace;
	delimiter = ",";
run;


proc sql;
	create table work.insurance_sql_table9 as
	select State
	, County
	, Metal_Level
	, Insurer
	, Plan_Type
	, Country
	, Metal_Ranking
	, Plan_ID
	, Situs

	from (
		select plans.State_Code as State
		, plans.County_Name as County
		, plans.Metal_Level
		, plans.Issuer_Name as Insurer
		, plans.Plan_Type
		, "USA" as Country

		, case when plans.Metal_Level = "Gold" then 1
		when plans.Metal_Level = "Silver" then 2
		when plans.Metal_Level = "Bronze" then 3
		else 0 end as Metal_Ranking

		, input(substr(plans.Plan_ID__Standard_Component_, 1, 3), 3.) as Plan_ID
		, locs.Situs
 
	from work.insur_xlsx as plans
	
		/*Here, we set up a left join with the merging dataset shorthanded as "locs".
		We set up the base datasets as "plans" above. Just after the join statement,
		we merge on the variable from the first dataset equal to the variable of the
		second dataset.*/
		left join work.issuer_locations as locs 
			on plans.issuer_name = locs.issuer_name)

	where Plan_Type = "PPO";
quit;


****************************
***SORTING AND COLLAPSING***
****************************;
*Finally, we come to sorting and collapsing. Now, you already know how to sort and collapse
in SAS, so learning to do it SQL is just extra. If you're writing a SQL step already,
it might be easiest to just continue with the SQL step to collapse. If you haven't used
a SQL step at all in your script, then it probably makes sense to just sort and collapse
with proc sort and proc means.;

*Regardless of your style, SQL sorting uses the "order by" statement
at the end of the query to sort the output. Following "order by", you can just add
the variables by which you want to sort.;
proc sql;
	create table work.insurance_sql_table9 as
	select State
	, County
	, Metal_Level
	, Insurer
	, Plan_Type
	, Country
	, Metal_Ranking
	, Plan_ID
	, Situs

	from (
		select plans.State_Code as State
		, plans.County_Name as County
		, plans.Metal_Level
		, plans.Issuer_Name as Insurer
		, plans.Plan_Type
		, "USA" as Country

		, case when plans.Metal_Level = "Gold" then 1
		when plans.Metal_Level = "Silver" then 2
		when plans.Metal_Level = "Bronze" then 3
		else 0 end as Metal_Ranking

		, input(substr(plans.Plan_ID__Standard_Component_, 1, 3), 3.) as Plan_ID
		, locs.Situs
 
	from work.insur_xlsx as plans

		left join work.issuer_locations as locs 
			on plans.issuer_name = locs.issuer_name)

	where Plan_Type = "PPO"

	order by State, Metal_Level;
quit;

*Notably, one major advantage of order by is that you can set up cases to sort in a very
particular way. For example, if you want to sort in order of Metal Level, but not
alphabetically, you could set up a case command in the order by statement:;
proc sql;
	create table work.insurance_sql_table9 as
	select State
	, County
	, Metal_Level
	, Insurer
	, Plan_Type
	, Country
	, Metal_Ranking
	, Plan_ID
	, Situs

	from (
		select plans.State_Code as State
		, plans.County_Name as County
		, plans.Metal_Level
		, plans.Issuer_Name as Insurer
		, plans.Plan_Type
		, "USA" as Country

		, case when plans.Metal_Level = "Gold" then 1
		when plans.Metal_Level = "Silver" then 2
		when plans.Metal_Level = "Bronze" then 3
		else 0 end as Metal_Ranking

		, input(substr(plans.Plan_ID__Standard_Component_, 1, 3), 3.) as Plan_ID
		, locs.Situs
 
	from work.insur_xlsx as plans

		left join work.issuer_locations as locs 
			on plans.issuer_name = locs.issuer_name)

	where Plan_Type = "PPO"

	/*Here, sort metal level with Silver first, follwed by Bronze, follwed by Gold.*/
	order by State
			, case when Metal_Level = "Silver" then 1
				when Metal_Level = "Bronze" then 2
				when Metal_Level = "Gold" then 3
				end;
quit;

*Additionally, collapsing is accomplished similarly to sorting. To collapse, we use the
"group by" command, with the stipulation that one of the variables you select must be
a statistical function that could work with a collapse. In the following example, we
find the average premium for a child by state.;
proc sql;
	create table work.avg_child_prem_by_state as
	select state_code, 
	mean(Premium_Child) as premium_child_mean

	from work.insur_xlsx

	group by state_code;
quit;

*It is recommended that you do SQL queries to clean data and collapse data in separate
steps. While you certainly can group by in the same query as all of the other commands,
it will be easier to keep track of things if you do it in two steps.;

*Additionally, if you select more variables than your group by statement, then sql will
collapse and then merge the collapsed results back in to your dataset. You need to be
careful. Sometimes this is useful, but you always need to track the variables in the
select and group by statements to ensure that you actually collapse or just merge in
summary stats correctly.;
proc sql;
	create table work.avg_child_prem_by_state_merged as
	select state_code
		, Issuer_Name
		, mean(Premium_Child) as premium_child_mean

	from work.insur_xlsx

	group by state_code;
quit;
