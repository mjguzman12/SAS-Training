*************************
*************************
*****SAS LESSON FOUR*****
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

*************
***REFRESH***
*************;
*Following up on the basic ways that we manipulated data in Lesson 3, let's launch
into some more complex methods. First, let's import another practice dataset.;

*For the sake of practice, we are going to walk through how to import an excel file.
This comes with a huge caveat: SAS does not like excel. While it is certainly possible
to import excel files in SAS, it can be tricky and there are many hidden challenges.
The first and most notable is that SAS literally needs to open Microsoft Excel to import
files. This implies that you need Microsoft Excel installed on your machine, and you
also need the 64-bit version of Excel. There are techinical reasons for this and ways to
get around this, but for now, just know that SAS and Excel need to work together to
import Excel files, and since SAS is a 64-bit program, Excel also needs to be the 64-bit
version so that the programs can communicate.;

*Following up on that caveat, here is an example import of an Excel file with all of the
typical specifications.;
proc import out = work.insur_xlsx
	datafile = "&raw\2-2016_QHP_Landscape_Individual_Market_Medical.xlsx"
	dbms = excel 
	replace; 
	sheet = "Data_AK-MT$";
	getnames = yes;
	mixed = yes;
	scantext = yes;
	usedate = yes;
run;

*Remove all labels in data. These supercede the variable names in the columns, so it is
confusing to look at these if they are not the same as the variable names. This is a
standard proc datasets command to modify work.insur_xlsx;
proc datasets library = work nolist;
   modify insur_xlsx;
     attrib _all_ label = "";
run;
quit;

*If the above command did not work for you, go on to the section below that imports the
same dataset as a CSV file. If the above command did work for you, note that importing an
Excel file requires a few additional specifications. 

***"sheet" specifies the sheet in an excel workbook.

***"mixed" is a specific excel specification that tells SAS that if there are 
	numeric and string variable types in a column, then it should use a string variable 
	type. 

***"scantext" specifies that if a column is a string column, then SAS should scan the
	observations in that column to find the longest string.

***"usedate" specifies that SAS should honor any excel date formatting, rather than
	reading dates as strings.;

*As you may have surmised, these are all excel-specific specifications, but they may be
useful nonetheless.;

*Here is the import command to import the same file from a csv format instead, in case
the above didn't work for you. Note that this will throw up some errors because there
are missing values in the numeric variables. You can ignore these though.;
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
	informat Drug_Deductible_Ind_87_Pe 		:$19.;
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

*As we go, we'll review a few concepts from Lesson 3, albeit quickly. First, subset 
to plans where Metal Level is Silver;
data work.insur_xlsx01;
	set work.insur_xlsx;
	if metal_level = "Silver";
run;

*Now, let's introduce another common function that you will use in SAS. "substr"
is simply a "substring" command. It takes three arguments: the first argument
is a string variable, the second argument is the starting position, and the
third argument is the ending position, and you are just extracting part of a
string.;

*Create a planid_5 variable, which is the first 5 characters of Plan ID.
Then turn planid_5 into a number and EHB Percent of Total Premium into a string. Note
that we are using the "substr" function to get the first 5 characters of 
the string, and then we are using the input and put commands that we used previously.;
data work.insur_xlsx02;
	set work.insur_xlsx01;
	planid_5_str = substr(Plan_ID__Standard_Component_, 1, 5);
	
	*input() converts strings to numeric, the second argument is the format. We use 12.; 
	planid_5 = input(planid_5_str, 12.);

	*put() converts numeric variables to strings, the second argument is the format. 
	We use 5.3 to specify 5 bytes total and and 3 bytes following the decimal place.;
	ehb_pc_tot_prem_str = put(EHB_Percent_of_Total_Premium, 5.3);
run;

*Order observations from highest to lowest EHB Percent of Total Premium using proc sort.;
proc sort data = work.insur_xlsx02 out = work.insur_xlsx02;
	by descending EHB_Percent_of_Total_Premium;
run;

*Find the average Premium Adult Individual Age 21 by planid_5 using proc means. Note that
you just created plan_id_5 in the data step above, and you are collapsing using the
mean summary statistic.;
proc means data = work.insur_xlsx02 nway noprint missing;
	class planid_5;
	var Premium_Adult_Individual_Age_21;
	output out = work.planid_5_avg_prem mean =;
run;

*Find the average Premium Child and Premium Adult Individual Age 21 by State Code and
Plan Type. Note once again that you are using nway to suppress the output of every
combination of class variables and you are taking the average of 3 variables;
proc means data = work.insur_xlsx02 nway noprint missing;
	class State_Code Plan_Type;
	var Premium_Child Premium_Adult_Individual_Age_21;
	output out = work.state_type_avg_prem mean = ;
run;


*************
***MERGING***
*************
*Merging datasets in SAS is reasonably straightforward. One stark difference between SAS
and other data tools is that data must be presorted to merge. You may not have realized
this, but in any merge, sorting is an integral step. Data is sorted alphanumerically,
and then data is simply matched down the list. Other tools such as Stata and R have sorts
built into their merge commands, so this is relatively "under the hood" for those tools.;

*Nothing too crazy here, we just need to run sorts on the two datasets that we're going
to merge on the merging variables:;
proc sort data = work.insur_xlsx02 out = work.insur_xlsx02;
	by state_code plan_type;
run;

proc sort data = work.state_type_avg_prem out = work.state_type_avg_prem;
	by state_code plan_type;
run;

*Now, keep, label, and rename variables prior to merging. Note that SAS will run multiple
data step commands in order, so there's no error if we keep and rename variables in a
single step. The labels here serve exactly the same function as Stata. They could be useful,
but it is purely personal preference if you want to change variable labels.;
data work.state_type_avg_prem01;
	set work.state_type_avg_prem;
	keep State_Code Plan_Type Premium_Child Premium_Adult_Individual_Age_21;
	label Premium_Child = "Average Premium Child";
	label Premium_Adult_Individual_Age_21 = "Average Premium Adult Individual Age 21";
	rename Premium_Child = avg_prem_child;
	rename Premium_Adult_Individual_Age_21 = avg_prem_21;
run;

*Now, we have the actual merge command, which is a completed in a data step. The syntax
is "merge work.dataset1 work.dataset2", and the following line specifies the (sorted)
variables on which you are merging. Here, we are merging our original dataset
work.insur_xlsx02 with the summary dataset work.state_type_avg_prem01.;
data work.insur_xlsx03;
	merge work.insur_xlsx02 work.state_type_avg_prem01;
	by State_Code Plan_Type;
run;

*Notably, some common shorthand is to use the (in=a) and (in=b) syntax. This allows you
to keep observations from one dataset. The following merge command only keeps observations
if they are contained in dataset a, or work.insur_xlsx02;
data work.insur_xlsx03;
	merge work.insur_xlsx02 (in=a) work.state_type_avg_prem01 (in=b);
	by State_Code Plan_Type;
	if a;
run;

*Now that we've merged the data, we have a lot of extra variables that we don't need
to keep. Just keep the vars we need in the following data step.;
data work.insur_xlsx03;
	set work.insur_xlsx03;
	keep State_Code State_Code County_Name Plan_ID__Standard_Component_ Premium_Adult_Individual_Age_: Issuer_Name Plan_Type Rating_Area Network_URL Primary_Care_Physician___Standar Customer_Service_Phone_Number_Lo Premium_Child Premium_Adult_Individual_Age_21 avg_prem_21;
run;


*******************************************************
***CONDITIONAL AND UNCONDITIONAL VARIABLE GENERATION***
*******************************************************;
*Moving on from merging, lets go to some conditional variable creation. In the following
command. we create a Blue Cross flag equalling 1 if Blue Cross is contained in Issuer Name.;
data work.insur_xlsx04;
	set work.insur_xlsx03;
	if find(Issuer_Name, "Blue Cross") then bc_flag = 1;
	else bc_flag = 0;
run;

*There are two things going on here. First, we are using some sudo-programming syntax in
an if-else statement. In SAS, the syntax for this type of statement is "if condition then __,
else __". Note that the if-then line ends with a semicolon, and the else line is its own
statement. Additionally, here, we use the "find" function as a condition. The find function
is a limited, easy-to-use regular expression that simply checks if certain characters are
contained in a string. It is limited because it is case sensitive and you cannot use other
regular expressions with it, so if you're trying to set up a flexible regular expression,
this is likely not your best bet. If you just need to do a quick check though, this will
get you what you need.;


*************************************
***REGULAR EXPRESSIONS AND STRINGS***
*************************************;
*Speaking of regular expressions, let's dive into more complex strings and regex functions.
First, we start with the "cats", and "compress" functions.:;
data work.insur_xlsx04;
	set work.insur_xlsx03;
	state_county = cats(State_Code, "-", County_Name);
	rating_area_test = compress(Rating_Area, " ");
run;

*The "cats" function is short for concatenation, and it simply concatenates the strings
that you specify. The compress function removes every instance of a specific character
in a string.;

*There are several regular expression functions in SAS that you may find useful, and
we will discuss two here. All of these begin with "PRX" which is short for "Perl 
Regular Expressions". Notably, Perl is a family of programming languages, and SAS regular
expressions borrow syntax from these languages in regex functions. These functions are 
frequently called "write only", as they are fairly easy to write, but they make little 
sense if you try to read them.:

***prxmatch: this is merely a regular expression match that returns the position of
	the regular expression string

***prxsubstr: this function can replace characters with another character string. Note
	that you could do this on an exact match using the "compress" function as well.

*The key thing for these regular expressions is that they begin and end with forward
slashes. This is the default delimiter for Perl, so that syntax is inherited from those
programming languages. Beyond that, the syntax is reasonably similar to what you may
have seen in Stata or R. Backslashes are escape characters, "*" matches any number of
characters, "." matches any one character, etc. While the pipe "|" does NOT mean
"or" in other SAS expressions, the pipe does signify "or" in these regular expressions.;

*Now, let's use these regular expressions to create a column base_net_url which takes all 
characters up to the ".com/.org/.net". Note that we do this in two steps. We find the
position of the ".com/.org/.net", and then we use the substr function to only keep
characters prior to the position.;
data work.insur_xlsx05;
	set work.insur_xlsx04;
	pos = prxmatch('/\.com|\.net|\.org/', Network_URL) + 3;
	base_net_url = substr(Network_URL, 1, pos);
run;

*The substr function that we just used has exactly the same functionality as in Stata.
The first argument is the variable, the second argument is the starting position, and
the third argument is the ending position. In this case, the ending position is the
pos variable that we created just before the substr function.

*Now, break the "Primary Care Physician - Standard" column into two. The first column
is the percent coinsurance, and the other will be the dollar copay amount. We can break
this column up by finding the "$" and "%" sign in each value. For dollar, take all numbers 
after the $ until the next space.;
data work.insur_xlsx06;
	set work.insur_xlsx05;
	
	*Step 1: Find the "$" in each line and asign this to the "pos1" variable. Then, create
	the "prim_care_phys_dollar_str" variable using pos1 and the variable, and then
	convert it to numeric in the prim_care_phys_dollar variable. Note that the "k"
	modifier allows for the reverse of the compress function. Instead of dropping
	the numeric characters, SAS will only "keep" the numeric characters in the new
	variable.;
	pos1 = prxmatch('/\$/',Primary_Care_Physician___Standar);
	if pos1 > 0 then prim_care_phys_dollar_str = substr(Primary_Care_Physician___Standar, 2, pos1 + 3);
	prim_care_phys_dollar0 = compress(prim_care_phys_dollar_str, "1234567890", "k");
	prim_care_phys_dollar = input(prim_care_phys_dollar0, 5.);

	*Step 2: do exactly the same thing to find the percentages, this time with a new
	variable name and with "pos2" and the regular expression position.;
	pos2 = prxmatch('/%/', Primary_Care_Physician___Standar);
	if pos2 > 0 then prim_care_phys_coinsur_str = substr(Primary_Care_Physician___Standar, pos2-2, pos2-1);
	prim_care_phys_coinsur0 = compress(prim_care_phys_coinsur_str, "1234567890", "k");
	prim_care_phys_coinsur = input(prim_care_phys_coinsur0, 5.);
run;

*Drop the unnecessary variables that we made earlier.;
data work.insur_xlsx07;
	set work.insur_xlsx06;
	drop bc_flag pos pos1 prim_care_phys_dollar_str prim_care_phys_dollar0 pos2 prim_care_phys_coinsur_str prim_care_phys_coinsur0;
run;

*Now, extract the area code from the "Customer Service Phone Number Local" variable.
Here, we use the "scan" function. Typically, this function would find the nth word
in a string variable. The first argument is the variable and the second argument
determines which word you want to return. Here, the third argument is the delimiter,
so rather than searching for space delimited text, we're searching for dash delimited,
which is much more appropriate for phone numbers.;
data work.insur_xlsx08;
	set work.insur_xlsx07;
	local_cust_svc_num_area_code_str = scan(Customer_Service_Phone_Number_Lo, 2, "-");
	local_cust_svc_num_area_code = input(local_cust_svc_num_area_code_str, 5.);
run;

*Finally, find the proportion of area codes that are toll-free (i.e. 800/888/877/866/855/844)
by insurer. To do this, first create a variable for toll free numbers, then create an
insurer variable that equals "UnitedHealthcare", "Anthem", "Aetna", "Humana", "Cigna",
or "Other", based on a series of if then regular expressions.;
data work.insur_xlsx09;
	set work.insur_xlsx08;
	toll_free = prxmatch('/8[00|88|77|66|55|44]/', local_cust_svc_num_area_code_str);
	if prxmatch('/UnitedHealthcare/', Issuer_name) > 0 then insurer = "UnitedHealthcare";
	if prxmatch('/Anthem/', Issuer_name) > 0 then insurer = "Anthem";
	if prxmatch('/Aetna/', Issuer_name) > 0 then insurer = "Aetna";
	if prxmatch('/Cigna/', Issuer_name) > 0 then insurer = "Cigna";
	if prxmatch('/Humana/', Issuer_name) > 0 then insurer = "Humana";
	if insurer = "" then insurer = "Other";
run;

*To find the proportion of toll free numbers by insurer, we are going to take
two steps. We'll collapse the data using proc means, and then we'll merge those
results back into the original dataset.;

*As we know, to merge, we need to sort first.;
proc sort data = work.insur_xlsx09 out = work.insur_xlsx09;
	by insurer;
run;

*Now, collapse the data using proc means.;
proc means data = work.insur_xlsx09 nway noprint missing;
	class insurer;
	var toll_free;
	output out = work.toll_free_by_insurer sum =;
run;

*Clean the collapsed dataset just a bit by dropping the _TYPE_ variable and making
the toll_free decimal into a percentage.;
data work.toll_free_by_insurer01;
	set work.toll_free_by_insurer;
	drop _TYPE_;
	pc_toll_free = 100 * (toll_free / _FREQ_);
run;

*Finally, merge toll_free_by_insurer1 back onto insur_xlsx09. Note the (in = a) and
(in = b) syntax once again, even though we don't use it here. Not necessary, but it's
a good habit to have this syntax in all of your merge commands regardless.;
data work.insur_xlsx10;
	merge work.insur_xlsx09(in = a) work.toll_free_by_insurer01 (in = b);
	by insurer;
run;


***************
***RESHAPING***
***************
*Now it's time for everyone's favorite subject. Reshaping in SAS is fairly straightforward.
Here, we Reshape all the Premium Adult Individual variables long by: State, Code, County,
Name, and Plan ID. Note: you can select all variables beginning with A by including A: 
in the keep() function.;
data work.wide;
	set work.insur_xlsx10;
	keep State_Code County_Name Plan_ID__Standard_Component_ Premium_Adult_Individual_Age_:;
run;

*Sort by Plan_ID__Standard_Component_ first;
proc sort data = work.wide out = work.wide;
	by State_Code County_Name Plan_ID__Standard_Component_;
run;

*The reshape command in SAS is proc transpose. Similarly to proc sort and proc means,
you cannot disaggregate proc transpose into a datastep. (Also, why would you? Who would 
want to rewrite the code behind a reshape?);
proc transpose 
	data = work.wide	
	out = work.long;
	by State_Code County_Name Plan_ID__Standard_Component_;
run;

*Additionally, you will need to rename the variables created in your reshape after you
run it. The variable created here were automatically named "_NAME_" and "_LABEL_".;

*Now, reshape the long dataset back to wide, with State_Code County_name Plan ID as ID
variables. First, turn the _NAME_ variable into a number so it can be a proper suffix--use 
substr to take the last two characters. Then, remove the age_str, _NAME_, and _LABEL_
columns.;
data work.long2;
	set work.long;
	age_str = substr(_NAME_, length(_NAME_)-1, 2);
	age = input(age_str, 5.);
	drop age_str _NAME_;
run;

*Reshape to wide, so use the prefex argument to tell SAS how to name the new variables,
and the id var as well.;
proc transpose
	data = work.long2
	out = work.wide2
	prefix = Premium_Adult_Individual_Age_;
	by State_Code County_Name Plan_ID__Standard_Component_;
	id age;
	var COL1;
run;
