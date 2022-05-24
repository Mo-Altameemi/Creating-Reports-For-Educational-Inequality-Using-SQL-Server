-------------------------------------------------
--- Creating a database for task 2 'cw_task2'---
-------------------------------------------------
create database cw_task2


---------------------------------
-- Activate database cw_task 2--
--------------------------------
use cw_task2


----------------------------------------------------
-- Start aploading the required dataset for task 2--
----------------------------------------------------



-----------------------------------------------
-- Viewing the imported dataset in sql server--
-----------------------------------------------

select * from [dbo].[vietnam_wave_1$]
select * from [dbo].[vietnam_wave_2$]

---------------------------------------------
--- Now we will start creating our tables ---
---------------------------------------------


-- Creating the 1st table 'student_performance'

drop table student_performance;
create table student_performance
(
Uniqueid nvarchar(50) NOT NULL,
StudentID int not null,
ABSENT_DAYS tinyint NULL,
STREADLR tinyint NULL,
STHGHGRD tinyint NULL,
STNONSCL tinyint NULL,
eng_rawscore tinyint NULL,
math_rawscore tinyint NULL,
atdtmsy tinyint NULL);

---------------------------------------------------------------------------
-- Now , we will insert our data into the new table 'student_performance'--		
---------------------------------------------------------------------------

insert into student_performance(Uniqueid,StudentID,ABSENT_DAYS,STREADLR,STHGHGRD,STNONSCL,eng_rawscore,
math_rawscore,atdtmsy)
select cast(uniqueid as nvarchar(50)), 
cast(StudentID as int),
cast (ABSENT_DAYS as tinyint),
cast(STREADLR as tinyint),
cast (STHGHGRD as tinyint),
cast (STNONSCL as tinyint),
cast (eng_rawscore as tinyint),
cast (math_rawscore as tinyint),
cast (atdtmsy as tinyint)
from [dbo].[vietnam_wave_1$]

select * from student_performance
------------------------------------------------------
-- Changing the column names to the meaningful names--
------------------------------------------------------
sp_rename 'student_performance.STREADLR', 'Reading_Times'
sp_rename 'student_performance.STHGHGRD', 'Expecting_Highest_Grade'
sp_rename 'student_performance.STNONSCL', 'Non_School_Work'
sp_rename 'student_performance.eng_rawscore', 'English_Score'
sp_rename 'student_performance.math_rawscore', 'Math_Score'
sp_rename 'student_performance.atdtmsy', 'student_attendance'

select * from student_performance

------------------------------------------------------------
-- Creating a view to change our data into meaningful data--
------------------------------------------------------------
drop view view_student_performance

Create view view_student_performance as 

select Uniqueid,ABSENT_DAYS,
case reading_times when 1 then
'Never' when 2 then 'OncePerMonth' when 3 then 'OncePerWeek' when 4 then 'Everyday' end as reading_times,
case expecting_highest_grade when 1 then 'general_secondary' when 2 then 'vocational_secondary'
when 3 then 'proffesional_schoo' when 4 then 'college' when 5 then 'vocational_college' when 6 then 'bachelore'
when 7 then 'master' when 8 then 'dectorate' else 'unknown' end as expecting_highest_grade,
case non_school_work when 0 then 'non' when 1 then 'less_1hr' when 2 then '1_2hr' when 3 then
'2_3hr' when 4 then 'more_than4hr' else 'unknown' end as hours_working_per_day,
english_score,math_score,
case student_attendance when 1 then 'normal' when 2 then 'higher_than_normal'
when 3 then'lower_than_normal' else 'unknown' end as student_attendance
from student_performance


select * from view_student_performance


------------------------------------------
-- Create the 2nd table 'student_and_parents'
----------------------------------------------
drop table student_and_parents
create table student_and_parents
(
UniqueID nvarchar(50) NOT NULL,
Ylchildid nvarchar(50) NOT NULL,
studentid int not null,
Ethnicity tinyint null,
Stdylchd bit Null,
Gender tinyint null,
Age tinyint null,
Mom_Read bit NULL,
Mom_Educ tinyint NULL,
Dad_Read bit NULL,
Dad_Educ tinyint Null,
STDLIV tinyint Null,
stplhl01 tinyint Null,
stplhl02 tinyint Null,
stplhl06 tinyint Null,
Stplhl03 tinyint Null);

------------------------------------------------------
-- Now , we will insert our data into the new table--		
------------------------------------------------------
insert into Student_and_Parents(UniqueID,Ylchildid,studentid,Ethnicity,Stdylchd,Gender
,Age,Mom_Read,Mom_Educ,Dad_Read,Dad_Educ,STDLIV,stplhl01,stplhl02,stplhl06,Stplhl03)
select cast (uniqueID as nvarchar(50)),
cast (Ylchildid as nvarchar(50)),
cast (StudentID as int),
cast (Ethnicity as tinyint),
cast (Stdylchd as bit),
cast (Gender as tinyint),
cast (Age as tinyint),
cast (Mom_Read as bit),
cast (Mom_Educ as tinyint),
cast (Dad_Read as bit),
cast (Dad_Educ as tinyint),
cast (Stdliv as tinyint),
cast (stplhl01 as tinyint),
cast (stplhl02 as tinyint),
cast (stplhl06 as tinyint),
cast (Stplhl03 as tinyint)
from [dbo].[vietnam_wave_1$]


------------------------------------------------------
-- Changing the column names to the meaningful names--
------------------------------------------------------
sp_rename 'student_and_parents.Ylchildid', 'Young_Live_StudentID'
sp_rename 'student_and_parents.Stdylchd', 'Young_Live_Student'
sp_rename 'student_and_parents.Stdliv', 'Living_Location'

sp_rename 'student_and_parents.stplhl01', 'TimesOfQuestion_AboutSchool' 
sp_rename 'student_and_parents.stplhl02', 'Times_Eating_Together'
sp_rename 'student_and_parents.stplhl06', 'help_with_english_hw'
sp_rename 'student_and_parents.Stplhl03', 'help_with_math_hw'

select * from student_and_parents

------------------------------------------------------------
-- Creating a view to change our data into meaningful data--
------------------------------------------------------------
drop view view_student_parents
Create View view_student_parents As
select Uniqueid,age,
case young_live_student when 0 then 'no' when 1 then 'yes' else 'unknown' end as young_live_student,
case ethnicity  when 1 then 'kinh' when 2 then 'H_Mong' when 3 then 'Cham_HRoi' when 4 then 'Ede'
when 5 then 'Ba_Na' when 6 then 'Nunh'when 7 then 'Tay' when 8 then 'Dao' when 9 then 'Gaiy' 
when 10 then 'Other' else 'unknown' end as Ethnicity,
case gender when 1 then 'Male' when 2 then 'Female' else 'unknown' end as Gender,
case mom_read when 0 then 'no' when 1 then 'yes' else 'unknown' end as mom_read, 
case dad_read when 0 then 'no' when 1 then 'yes'else 'unknown' end as dad_read,
case living_location when 1 then 'with_parents' when 2 then 
'family_or_friend'when 3 then 'school_hostel' when 4 then 'private_hostel' 
when 5 then 'others' else 'unknown' end as living_location,
case TimesOfQuestion_AboutSchool when 1 then 'never' when 2 then 'once_per_month' 
when 3 then 'twice_per_week' when 4 then 'everday' else 'unknown' end as TimesOfQuestion_AboutSchool,
case times_eating_together when 1 then 'never' when 2 then 'once_per_month' 
when 3 then 'twice_per_week' when 4 then 'everday' else 'unknown' end as times_eating_together,
case help_with_english_hw when 1 then 'never' when 2 then 'once_per_month' 
when 3 then 'twice_per_week' when 4 then 'everday' else 'unknown' end as help_with_english_hw,
case help_with_math_hw when 1 then 'never' when 2 then 'once_per_month' 
when 3 then 'twice_per_week' when 4 then 'everday' else 'unknown' end as help_with_math_hw 
from student_and_parents 

select * from view_student_parents

--------------------------------------------
-- Create the 3rd table 'Student_Health'
-------------------------------------------
drop table if exists Student_Health
create table Student_Health
(
UniqueID nvarchar(50) NOT NULL,
STDHLTH1 bit null,
STDHLTH2 bit null,
STDHLTH3 bit null,
STDHLTH4 bit null,
STDHLTH5 bit null,
STDHLTH6 bit null,
STDHLTH0 bit null,
StdMeal tinyint Null,); 


------------------------------------------------------
-- Now , we will insert our data into the new table--		
------------------------------------------------------

insert into Student_Health(UniqueID,STDHLTH1,STDHLTH2 ,STDHLTH3 ,STDHLTH4,STDHLTH5 
,STDHLTH6,STDHLTH0,StdMeal)
select cast (UniqueID as nvarchar(50)),
cast (STDHLTH1 as bit),
cast (STDHLTH2 as bit),
cast (STDHLTH3 as bit),
cast (STDHLTH4 as bit),
cast (STDHLTH5 as bit),
cast (STDHLTH6 as bit),
cast (STDHLTH0 as bit),
cast (StdMeal as tinyint)
from [dbo].[vietnam_wave_1$]


------------------------------------------------------
-- Changing the column names to the meaningful names--
------------------------------------------------------
sp_rename 'student_health.STDHLTH1', 'Sight_Problems'
sp_rename 'student_health.STDHLTH2', 'Hearing_Problems'
sp_rename 'student_health.STDHLTH3', 'Headaches'
sp_rename 'student_health.STDHLTH4', 'Fever'
sp_rename 'student_health.STDHLTH5', 'Stomach_Problems'
sp_rename 'student_health.STDHLTH6', 'Other_Health_Problems'
sp_rename 'student_health.STDHLTH0', 'No_Health_Problems'
sp_rename 'student_health.StdMeal', 'Meals_Per_Day'

select * from Student_Health


------------------------------------------------------------
-- Creating a view to change our data into meaningful data--
------------------------------------------------------------
drop view view_student_health
create view view_student_health as 
select  uniqueid,case Sight_Problems when 0 then 'no' when 1 then 'yes' else 'unknown' end as Sight_Problems, 

case Hearing_Problems when 0 then 'no' when 1 then 'yes' else 'unknown' end as Hearing_Problems, 

case Headaches when 0 then 'no' when 1 then 'yes' else 'unknown' end as Headaches, 

case Fever when 0 then 'no' when 1 then 'yes' else 'unknown' end as Fever, 

case Stomach_Problems when 0 then 'no' when 1 then 'yes' else 'unknown' end as Stomach_Problems, 

case Other_health_Problems when 0 then 'no' when 1 then 'yes' else 'unknown' end as Other_Health_Problems, 

case No_health_Problems when 0 then 'no' when 1 then 'yes' else 'unknown' end as No_Health_Problems, 

case Meals_Per_Day when 1 then 'One_Meal' when 2 then 'Two_Meals' when 3 then 'Three_or_More_Meals' 
else 'unknown' end as Meals_Per_Day 

from Student_Health

select * from view_student_health
------------------------------------------------
-- Create 4th table 'Student_Wellbeing'
-------------------------------------------------
drop table if exists Student_Wellbeing
Create table Student_Wellbeing
(
UniqueID nvarchar(50) NOT NULL,
STPPLHM tinyint null,
STPLSTDY bit null,
STHVMTEL bit null,
STHVTELE bit null,
STHVBIKE bit null,
STHVAIRC bit null,
STHVCAR bit null,
STHVCOMP bit null,
STHVINTR bit null,
STHVFRDG bit null,
STHVMCRO bit null); 


------------------------------------------------------
-- Now , we will insert our data into the new table--		
------------------------------------------------------

insert into Student_Wellbeing(uniqueid,STPPLHM,STPLSTDY,STHVMTEL,STHVTELE,
STHVBIKE,STHVAIRC,STHVCAR,STHVCOMP,STHVINTR,STHVFRDG,STHVMCRO)
select cast (UniqueID as nvarchar(50)),
cast (STPPLHM  as tinyint),
cast (STPLSTDY as bit),
cast (STHVMTEL as bit),
cast (STHVTELE as bit),
cast (STHVBIKE as bit),
cast (STHVAIRC as bit),
cast (STHVCAR as bit),
cast (STHVCOMP as bit),
cast (STHVINTR as bit),
cast (STHVFRDG as bit),
cast (STHVMCRO as bit)
from [dbo].[vietnam_wave_1$]



------------------------------------------------------
-- Changing the column names to the meaningful names--
------------------------------------------------------
sp_rename 'Student_Wellbeing.STPPLHM', 'People_Living_InYourHome'
sp_rename 'Student_Wellbeing.STPLSTDY', 'PlaceToStudy_InYourHome'
sp_rename 'Student_Wellbeing.STHVMTEL', 'MobilePhone'
sp_rename 'Student_Wellbeing.STHVTELE', 'Television_InYourHome'
sp_rename 'Student_Wellbeing.STHVBIKE', 'Bike'
sp_rename 'Student_Wellbeing.STHVAIRC', 'AirConditioning_InYourHome'
sp_rename 'Student_Wellbeing.STHVCAR', 'Car_InYourHome'
sp_rename 'Student_Wellbeing.STHVCOMP', 'Computer_InYourHome'
sp_rename 'Student_Wellbeing.STHVINTR', 'Internet_InYourHome'
sp_rename 'Student_Wellbeing.STHVFRDG', 'Fridge_InYourHome'
sp_rename 'Student_Wellbeing.STHVMCRO', 'Microwave_InYourHome'

select * from Student_Wellbeing





------------------------------------------------------------
-- Creating a view to change our data into meaningful data--
------------------------------------------------------------
drop view view_student_wellbeing
create view view_student_wellbeing as
select uniqueid ,people_living_inyourhome , 
case placetostudy_inyourhome when 1 then 'yes' when 0 then'no'else'unknown'end as placetostudy_inyourhome,
case mobilephone  when 1 then 'yes' when 0 then'no'else'unknown'end as mobilephone,
case television_inyourhome  when 1 then 'yes' when 0 then'no'else'unknown'end as television_inyourhome,
case bike  when 1 then 'yes' when 0 then'no'else'unknown'end as bike,
case airconditioning_inyourhome  when 1 then 'yes' when 0 then'no'else'unknown'end as airconditioning_inyourhome,
case car_inyourhome  when 1 then 'yes' when 0 then'no'else'unknown'end as car_inyourhome,
case computer_inyourhome when 1 then 'yes' when 0 then'no'else'unknown'end as computer_inyourhome,
case internet_inyourhome when 1 then 'yes' when 0 then'no'else'unknown'end as internet_inyourhome,
case fridge_inyourhome when 1 then 'yes' when 0 then'no'else'unknown'end as fridge_inyourhome,
case microwave_inyourhome when 1 then 'yes' when 0 then'no'else'unknown'end as microwave_inyourhome
from Student_Wellbeing


select * from view_student_wellbeing





---------------------------------------------------------------
--Create 5th table 'Class_Info'
------------------------------------------------------------
drop table if exists class_info
create table class_info
(
UniqueID nvarchar(50) NOT NULL,
CLASSID int not null,
GRLENRL tinyint Null,
BOYENRL tinyint Null,
TTLENRL tinyint Null,
TGRLENRL tinyint Null,
TBOYENRL tinyint Null,
TTTLENRL tinyint Null)

------------------------------------------------------
-- Now , we will insert our data into the new table--		
------------------------------------------------------

insert into class_info(UniqueID,CLASSID,GRLENRL,BOYENRL,TTLENRL,TGRLENRL,
TBOYENRL,TTTLENRL)
select cast (UniqueID as nvarchar(50)),
cast (CLASSID as int),
cast (GRLENRL as tinyint), 
cast (BOYENRL as tinyint),
cast (TTLENRL as tinyint), 
cast (TGRLENRL as tinyint),
cast (TBOYENRL as tinyint),
cast (TTTLENRL as tinyint)
from [dbo].[vietnam_wave_1$]


------------------------------------------------------
-- Changing the column names to the meaningful names--
------------------------------------------------------
sp_rename 'class_info.GRLENRL', 'Total_Girls_InClass'
sp_rename 'class_info.BOYENRL', 'Total_Boys_InClass'
sp_rename 'class_info.TTLENRL', 'Total_EnrolmentInClass_Both'
sp_rename 'class_info.TGRLENRL', 'Total_Attendance_By_Girls'
sp_rename 'class_info.TBOYENRL', 'Total_Attendance_By_Boys'
sp_rename 'class_info.TTTLENRL', 'Total_Attendance_By_Both'

select * from class_info
---------------------------------------------------
--Create 6th table 'school_quality'
-----------------------------------------------------
drop table if exists School_Quality
create table School_Quality
(
UniqueID nvarchar(50) NOT NULL,
SCHOOLID smallint NOT NULL,
LOCALITY tinyint null,
STTMSCH smallint null,
STGR1006 tinyint null,
STGR1007 tinyint null,
SCAVLB1 bit null,
SCAVLB3 bit null,
SCAVLB4 bit null,
SCAVLB6 bit null,
SCAVLB7 bit null,
SCAVLB8 bit null,
SCAVLB10 bit null,
HTTYPSCH tinyint null)


------------------------------------------------------
-- Now , we will insert our data into the new table--		
------------------------------------------------------

insert into school_quality (UniqueID,SCHOOLID,LOCALITY,STTMSCH,STGR1006,STGR1007,
SCAVLB1,SCAVLB3,SCAVLB4,SCAVLB6,SCAVLB7,SCAVLB8,SCAVLB10,HTTYPSCH)
select cast (UniqueID as nvarchar(50)),
cast (schoolid as int),
cast (LOCALITY as tinyint),
cast (STTMSCH as smallint),
cast (STGR1006 as tinyint),
cast (STGR1007 as tinyint),
 cast (SCAVLB1 as bit),
 cast (SCAVLB3 as bit),
 cast (SCAVLB4 as bit),
 cast (SCAVLB6 as bit),
 cast (SCAVLB7 as bit),
 cast (SCAVLB8 as bit),
 cast (SCAVLB10 as bit),
 cast (HTTYPSCH as tinyint)
 from [dbo].[vietnam_wave_1$]


------------------------------------------------------
-- Changing the column names to the meaningful names--
------------------------------------------------------
sp_rename 'School_Quality.LOCALITY', 'School_Location'
sp_rename 'School_Quality.STTMSCH', 'Time_to_school_Minutes'
sp_rename 'School_Quality.STGR1006', 'JoiningReason_Good_Quality_Teaching' 
sp_rename 'School_Quality.STGR1007', 'JoiningReason_High_Student_Achievemnts'
sp_rename 'School_Quality.SCAVLB1', 'Chalk_Or_BoardMarker'
sp_rename 'School_Quality.SCAVLB3', 'Teacher_Desk'
sp_rename 'School_Quality.SCAVLB4', ' Teacher_Chair '
sp_rename 'School_Quality.SCAVLB6', 'Electric_Light'
sp_rename 'School_Quality.SCAVLB7', ' Electric_Fan'
sp_rename 'School_Quality.SCAVLB8', ' Windows_With_Glass'
sp_rename 'School_Quality.SCAVLB10', 'IT_Facilities'
sp_rename 'School_Quality.HTTYPSCH', 'School_Type'

select * from School_Quality
------------------------------------------------------------
-- Creating a view to change our data into meaningful data--
------------------------------------------------------------
drop view view_school_quality
Create view view_school_quality as 
select uniqueid,schoolid,time_to_school_minutes,
case school_location when 1 then 'rural' when 2 then 'urban' else 'unknown'
end as School_Location,
case joiningreason_good_quality_teaching when 1 then 'not_important' when 2 then 'somewhat_important' 
when 3 then ' important'when 4 then 'very_important' else 'unknown' end as joiningreason_good_quality_teaching,
case JoiningReason_High_Student_Achievemnts when 1 then 'not_important' when 2 then 'somewhat_important'
when 3 then ' important' when 4 then 'very_important' else 'unknown' end as JoiningReason_High_Student_Achievemnts,
case chalk_or_boardmarker when 1 then 'yes' when 0 then 'no' else 'unknown' end as chalk_or_boardmarker,
case teacher_desk when 1 then 'yes'
when 0 then 'no' else 'unknown'end as teacher_desk,
case electric_light when 1 then 'yes' when 0 then 'no' 
else 'unknown' end as electric_light,
case IT_Facilities when 1 then 'yes' 
when 0 then 'no' else 'unknown' end as IT_Facilities,
case school_type when 1 then 'government' when 2 then 'private' when 3 then 'other' else 'unknwon' end as school_type
from School_Quality

select * from view_school_quality

----------------------------------------
--Create 7th table 'Teacher_Info'
-------------------------------------------
drop table if exists Teacher_Info
create table Teacher_Info
(
uniqueid nvarchar(50) not null,
HTAGE tinyint null,
HTSEX tinyint null,
HTCURRLE tinyint null,
HTYRSHT tinyint null,
HTLVLEDC tinyint null,
HTEXCTCH tinyint null)

------------------------------------------------------
-- Now , we will insert our data into the new table--		
------------------------------------------------------

insert into Teacher_Info(uniqueid,HTAGE,HTSEX,HTCURRLE,HTYRSHT,HTLVLEDC,HTEXCTCH)
select CAST (uniqueid as nvarchar),
cast (HTAGE as tinyint),
cast (HTSEX as tinyint),
cast (HTCURRLE as tinyint),
cast (HTYRSHT as tinyint),
cast (HTLVLEDC as tinyint),
cast (HTEXCTCH as tinyint)
from[dbo].[vietnam_wave_1$]



------------------------------------------------------
-- Changing the column names to the meaningful names--
------------------------------------------------------
sp_rename 'Teacher_Info.HTAGE', 'Teacher_Age'
sp_rename 'Teacher_Info.HTSEX', 'Teacher_Gender'
sp_rename 'Teacher_Info.HTCURRLE', 'Teacher_Current_Level'

sp_rename 'Teacher_Info.HTYRSHT', 'Teacher_number_of_years_current_roles'
sp_rename 'Teacher_Info.HTLVLEDC', 'Teacher_highest_level'
sp_rename 'Teacher_Info.HTEXCTCH', 'Awarded_ExcellentTeacher'

select * from Teacher_Info

------------------------------------------------------------
-- Creating a view to change our data into meaningful data--
------------------------------------------------------------
drop view view_teacher_info
create view view_teacher_info as

select Uniqueid,

case teacher_gender when 1 then 'Male' when 2 then 'Female' else 'Unknown' end as Teacher_Gender,

case Teacher_current_level when 1 then 'Director' when 2 then 'Vice' when 3 then 'Another' else
'Unknown' end as Teacher_current_level,teacher_number_of_years_current_roles as teacher_in_current_roles_by_years,

case teacher_highest_level when 1 then 'Upper_Secondary'
when 2 then 'Vocational_training_school' when 3 then 'College' when 4 then 'Uni_Undergraduate' when 5
then ' Uni_Master' else 'Unknown' end as teacher_highest_level ,

case awarded_excellentteacher when 0 then 'never' when 1 then 'yes_school_level' when 2 then 
'yes_district_level' when 3 then 'yes_province_level' else 'unknown' end as awarded_excellent_teacher

from Teacher_Info

select * from view_teacher_info


-------------------------------------------------------
-------Now we will create our Reports' Views ----------
-------------------------------------------------------


-------------
--Report 1 --
-------------
drop view v_ethnicity_performance
create view v_Ethnicity_Performance as
select e.Ethnicity, AVg(f.Math_score) as Math_Score, 
Avg(f.English_score) as English_score from view_student_performance as f
inner join view_student_parents as e  on f.UniqueID = e.UniqueID group by Ethnicity

select * from v_Ethnicity_Performance



--------------
-- Report 2--
--------------
drop view boys_girls_percentage
create view boys_girls_percentage  as 

select uniqueid,cast(total_girls_inclass as decimal)/total_Enrolmentinclass_both*100
as Girles_Enrolment_Percentage,cast(total_attendance_by_girls as decimal)/total_attendance_by_both*100
as Girls_Attendance_Percentage,cast(total_boys_inclass as decimal)/total_Enrolmentinclass_both*100 as 
Boys_Enrolment_Percentage,cast(total_attendance_by_boys as decimal)/total_attendance_by_both*100 as
Boys_Attendance_Percentage
from class_info 

select * from boys_girls_percentage

----------------------------------

--------------
-- Report 3--
--------------

drop view v_gender_and_living_location
create view v_gender_and_living_location as

select a.boys_enrolment_percentage,a.Girles_Enrolment_Percentage,b.dad_read,
b.mom_read,b.living_location from boys_girls_percentage a join view_student_parents b
on a.uniqueid=b.Uniqueid where dad_read = 'no' and mom_read ='no' 


select * from v_gender_and_living_location


--------------
-- Report 4 --
--------------
drop view by_gender
create view by_gender as

select uniqueid, case when gender = 'male' then 1 else 0 end as Boys, case when 
gender = 'female' then 1 else 0 end as Girls from view_student_parents 

select * from by_gender

-----------------------------------------------------------
--------------
-- Report 5 --
--------------

drop view v_school_work
create view v_school_work as

select a.Boys,a.Girls,b.reading_times from by_gender a inner join 
view_student_performance b
on a.Uniqueid=b.Uniqueid 


select * from v_school_work

--------------
-- Report 6 --
--------------
drop view v_uniqueid_with_ethnicity
create view v_uniqueid_with_ethnicity as
select a.uniqueid,a.placetostudy_inyourhome,a.internet_inyourhome
,b.ethnicity from[dbo].[view_student_wellbeing] a
join view_student_parents b on b.Uniqueid=a.uniqueid


select * from v_uniqueid_with_ethnicity

-------------
-- Report 7--
-------------
drop view v_working_hours_by_age
create view v_working_hours_by_age as

select Age as Student_Age,count(a.age)as Number_of_Students,b.Hours_working_per_day
from [dbo].[view_student_parents] a
join view_student_performance b 
on a.UniqueID=b.Uniqueid group by Age, hours_working_per_day

select * from v_working_hours_by_age

select age,count(a.age)as Students_Number,b.hours_working_per_day from [dbo].[view_student_parents] a
join view_student_performance b 
on a.UniqueID=b.Uniqueid group by Age, hours_working_per_day

select * from v_working_hours_by_age


-----------------
-- Report -- 8 --
-----------------
drop view V_absent_days_school_id
create view V_absent_days_school_id as

select a.absent_days,b.schoolid from view_student_performance a join view_school_quality b
on b.uniqueid=a.Uniqueid
where ABSENT_DAYS > 1 group by a.ABSENT_DAYS,b.schoolid

select * from v_working_hours_by_age


---------------------------------------------------------------------------------------

-----------------
-- Report -- 9 --
-----------------

drop view v_gender_and_living_location

create view v_gender_and_living_location111 as

select avg(a.boys_enrolment_percentage) as Average_Enrolment_Boys,avg(a.Girles_Enrolment_Percentage)
as Average_Enrolment_Girls,b.dad_read,
b.mom_read,b.living_location from boys_girls_percentage a join view_student_parents b
on a.uniqueid=b.Uniqueid where dad_read = 'no' and mom_read ='no' 
group by living_location,dad_read,mom_read

select * from v_gender_and_living_location


----------------------------------------------------------------------------------------

--------------------------
--- Create Procedure 1 ---
--------------------------

create procedure Ethnicity_Score_Finding
@Ethnicity as varchar(100)
as
select e.Ethnicity, AVg(f.Math_score) as Math_Score, 
avg(f.English_score) as English_score from view_student_performance as f
inner join view_student_parents as e  on f.UniqueID = e.UniqueID 
where ethnicity=@Ethnicity
group by Ethnicity  

exec Ethnic_Score_Finding @Ethnicity = kinh

--------------------------------------------------------------------------
--------------------------
--- Create Procedure 2 ---
--------------------------

create procedure School_ID_Founder_By_Absent_Days
@schoolid as smallint
as
select a.absent_days,b.schoolid from view_student_performance a join view_school_quality b
on b.uniqueid=a.Uniqueid
where ABSENT_DAYS > 1 and schoolid=@schoolid group by ABSENT_DAYS,b.schoolid order by ABSENT_DAYS desc 
  

exec School_ID_Founder_By_Absent_Days @schoolid = '5328'
-------------------------------------------
--------------------------
--- Create Procedure 3 ---
--------------------------
Create procedure Living_Location_Finder
@living_location as varchar(100)
as

select avg(a.boys_enrolment_percentage) as Boys_Enrolment_Percentage ,avg(a.Girles_Enrolment_Percentage)
as Girls_Enrolment_Percentage,b.dad_read,
b.mom_read,b.living_location from boys_girls_percentage a join view_student_parents b
on a.uniqueid=b.Uniqueid where dad_read = 'no' and mom_read ='no' and living_location = @living_location
group by living_location,dad_read,mom_read

 exec Living_Location_Finder @living_location = with_parents
