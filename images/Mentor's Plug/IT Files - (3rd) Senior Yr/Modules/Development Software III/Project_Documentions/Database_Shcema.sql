USE STUDENT_COUNSELLING_SYSTEM;

IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.name='ADDRESS')
CREATE TABLE [ADDRESS]
(
 [address_id] INTEGER IDENTITY(0,1) NOT NULL,
 [country]    VARCHAR(50) NOT NULL,
 [province]   VARCHAR(50) NOT NULL,
 [city]       VARCHAR(50) NOT NULL,
 [street]     VARCHAR(50) NOT NULL,
 [zip_code]   INTEGER NOT NULL,

 CONSTRAINT [Address_address_id] PRIMARY KEY CLUSTERED ([address_id] ASC)
);
--CREATE INDEX address_indx ON ADDRESS(city)


IF NOT EXISTS(SELECT * FROM sys.tables t WHERE t.name='STUDENT')
CREATE TABLE STUDENT
(
	[stu_id] BIGINT IDENTITY(22200,1) NOT NULL,
	[stu_fname] VARCHAR(50) NOT NULL,
	[stu_lname] VARCHAR(50) NOT NULL,
	[stu_DOB] DATE NOT NULL,
	[stu_age]  AS (DATEDIFF(year, stu_DOB, GETDATE())),
	[stu_gender] CHAR(1) CHECK(stu_gender IN ('M','F')) NOT NULL,
	[stu_email] VARCHAR(50) NOT NULL,
	[stu_phone] VARCHAR(10) NOT NULL,
	[stu_signup_date] DATETIME DEFAULT GETDATE(),
	[stu_password] VARBINARY(200),
	[stu_address] INTEGER 

	CONSTRAINT [stu_address_fk] FOREIGN KEY REFERENCES ADDRESS(address_id)
	CONSTRAINT [STUDENT_stu_id] PRIMARY KEY CLUSTERED([stu_id] ASC)
);
--CREATE INDEX student_index ON STUDENT(stu_fname);

IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='COUNSELLOR')
CREATE TABLE COUNSELLOR
(
 [counsellor_id] BIGINT IDENTITY(200220, 1),
 [counsellor_fname] VARCHAR(50) NOT NULL,
 [counsellor_lname] VARCHAR(50) NOT NULL,
 [counsellor_DOB] DATE NOT NULL,
 [counsellor_age] AS(DATEDIFF(year, counsellor_DOB, GETDATE())),
 [counsellor_gender] CHAR(1) CHECK(counsellor_gender IN ('M','F')) NOT NULL,
 [counsellor_email] VARCHAR(50) NOT NULL UNIQUE,
 [counsellor_phone] VARCHAR(10) NOT NULL UNIQUE,
 [counsellor_signup_date] DATE DEFAULT GETDATE(),
 [counsellor_password] VARBINARY(200) NOT NULL,
 [counsellor_address] INTEGER
 
 CONSTRAINT[counsellor_address_fk] FOREIGN KEY REFERENCES ADDRESS(address_id)
 CONSTRAINT[COUNSELLOR_counsellor_index] PRIMARY KEY([counsellor_id] ASC)
 
);
--CREATE INDEX counsellor_index ON COUNSELLOR(counsellor_fname);
 
 IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='ADMINISTRATOR')
 CREATE TABLE ADMINISTRATOR(
	[admin_id] BIGINT IDENTITY(1011100,1),
	[admin_fname] VARCHAR(50) NOT NULL,
	[admin_lname] VARCHAR(50) NOT NULL,
	[admin_DOB] DATE NOT NULL,
	[admin_age] AS(DATEDIFF(year, admin_DOB, GETDATE())),
	[admin_gender] CHAR(1) CHECK( admin_gender IN ('M','F')) NOT NULL,
	[admin_email] VARCHAR(50) NOT NULL UNIQUE,
	[admin_phone] VARCHAR(10) NOT NULL UNIQUE,
	[admin_signup-date] DATE DEFAULT GETDATE(),
	[admin_password] VARBINARY(200) NOT NULL,
	[admin_address] INTEGER
	
	CONSTRAINT[admin_address_fk] FOREIGN KEY REFERENCES ADDRESS(address_id)
	CONSTRAINT[ADMIN_admin_index] PRIMARY KEY CLUSTERED([admin_id] ASC)
 );
--CREATE INDEX admin_index ON ADMINISTRATOR(admin_fname);

		--THESE ARE ADMIN RELATIONS
IF NOT EXISTS(SELECT * FROM sys.tables t WHERE T.NAME='EVENT')
 CREATE TABLE EVENT(
	[event_id] BIGINT IDENTITY(10930, 1),
	[event_name] VARCHAR(50) NOT NULL,
	[event_description] TEXT NOT NULL,
	[event_date] DATE NOT NULL,
	[event_created_date] DATE DEFAULT GETDATE(),
	[event_updated_at] DATE DEFAULT GETDATE(),
	[admin_id] BIGINT

	CONSTRAINT[EVENT_admin_id_fk] FOREIGN KEY REFERENCES ADMINISTRATOR(admin_id)
	CONSTRAINT[EVENT_event_id] PRIMARY KEY CLUSTERED([event_id] ASC) 
 );
 --CREATE INDEX event_index ON EVENT(event_name);
 
IF NOT EXISTS(SELECT * FROM sys.tables t WHERE t.NAME='CORE_SERVICE')
 CREATE TABLE CORE_SERVICE(
	[service_id] BIGINT IDENTITY(806640,1),
	[service_name] VARCHAR(50) NOT NULL,
	[service_description] TEXT NOT NULL,
	[service_created_date] DATE DEFAULT GETDATE(),
	[admin_id] BIGINT 
	
	CONSTRAINT[SERVICE_admin_id_fk] FOREIGN KEY REFERENCES ADMINISTRATOR(admin_id)
	CONSTRAINT[SERVICE_service_id] PRIMARY KEY CLUSTERED([service_id] asc)
 );
 --CREATE INDEX service_index ON CORE_SERVICE(service_name);

 IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='COMMON_ISSUES')
  CREATE TABLE COMMON_ISSUES(
	[common_issue_id] BIGINT IDENTITY(20500, 1),
	[common_issue_name] VARCHAR(50) NOT NULL UNIQUE,
	[common_issue_description] TEXT NOT NULL,
	[common_issue_created_date] DATE DEFAULT GETDATE(),
	[admin_id] BIGINT
	
	CONSTRAINT[ISSUE_admin_id_fk] FOREIGN KEY REFERENCES ADMINISTRATOR(admin_id)
	CONSTRAINT[ISSUE_issue_id] PRIMARY KEY CLUSTERED([common_issue_id] ASC)
  );
  --CREATE INDEX issue_index ON COMMON_ISSUES(common_issue_name);

IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='EMERGENCY_RESOURCES')
 CREATE TABLE EMERGENCY_RESOURCES(
	[emergency_resource_id] BIGINT IDENTITY(90460, 1),
	[emergency_resource_name] VARCHAR(50) NOT NULL,
	[emergency_resource_phone] VARCHAR(20) NOT NULL UNIQUE,
	[emergency_resource_created_date] DATE DEFAULT GETDATE(),
	[admin_id] BIGINT

	CONSTRAINT[EMERGENCY_RESOURCE_admin_id] FOREIGN KEY REFERENCES ADMINISTRATOR(admin_id)
	CONSTRAINT[EMERGENCY_emergency_resource_id] PRIMARY KEY CLUSTERED([emergency_resource_id] ASC)
 );
 --CREATE INDEX emergency_index ON EMERGENCY_RESOURCES(emergency_resource_name);
	

			--THESE ARE COUNSELLOR RELATIONS
IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='RATING')
 CREATE TABLE RATING(
	[rating_id] BIGINT IDENTITY(0,1),
	[rating_star] CHAR(1) CHECK(rating_star IN ('1','2','3','4','5')),
	[rating_date] DATE DEFAULT GETDATE(),
	[stu_id] BIGINT FOREIGN KEY REFERENCES STUDENT(stu_id),
	[counsellor_id] BIGINT FOREIGN KEY REFERENCES COUNSELLOR(counsellor_id)

	CONSTRAINT[RATING_rating_id] PRIMARY KEY CLUSTERED([rating_id] ASC)
 );
 --CREATE INDEX rating_index ON RATING(rating_star);
 
IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='APPOINTMENT')
  CREATE TABLE APPOINTMENT(
	[appointment_id] BIGINT IDENTITY(40770, 1),
	[appointment_date] DATE DEFAULT GETDATE(),
	[stu_id] BIGINT FOREIGN KEY REFERENCES STUDENT(stu_id),
	[counsellor_id] BIGINT FOREIGN KEY REFERENCES COUNSELLOR(counsellor_id)

	CONSTRAINT[APPOINTMENT_appointment_id] PRIMARY KEY CLUSTERED ([appointment_id] ASC)
  );
 --CREATE INDEX appointment_index ON APPOINTMENT(appointment_date);

IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='SESSION')
 CREATE TABLE SESSION(
	[session_id] BIGINT IDENTITY(5100, 1),
	[session_date] DATE NOT NULL,
	[session_type] VARCHAR(20) CHECK ([session_type] IN ('PHYSICAL', 'VIRTUAL')) NOT NULL,
	[appointment_id] BIGINT FOREIGN KEY REFERENCES APPOINTMENT(appointment_id)

	CONSTRAINT[SESSION_session_id] PRIMARY KEY CLUSTERED ([session_id] ASC)
 );
  --CREATE INDEX session_index ON SESSION(session_type)

 IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='SESSION_NOTE')
 CREATE TABLE SESSION_NOTE(
	[session_note_id] BIGINT IDENTITY(30150, 1),
	[session_note_header] VARCHAR(50) NOT NULL,
	[session_note_description] TEXT NOT NULL,
	[session_id] BIGINT FOREIGN KEY REFERENCES SESSION(session_id)

	CONSTRAINT[SESSION_session_note_pk] PRIMARY KEY CLUSTERED ([session_note_id] ASC)
 );
 --CREATE INDEX session_note_index ON SESSION_NOTE(session_note_header);


			--THESE ARE STUDENT RELATIONS
IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='COMMENT')
 CREATE TABLE COMMENT(
	[comment_id] BIGINT IDENTITY(0, 1),
	[comment_description] TEXT NOT NULL,
	[comment_date] DATE DEFAULT GETDATE(),
	[stu_id] BIGINT FOREIGN KEY REFERENCES STUDENT(stu_id)

	CONSTRAINT[COMMENT_comment_id] PRIMARY KEY CLUSTERED ([comment_id] ASC)
 );
 ---CREATE INDEX comment_index ON COMMENT(comment_date)

IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='MOOD')
 CREATE TABLE MOOD(
	[mood_id] BIGINT IDENTITY(1000, 1),
	[mood_rate] VARCHAR(50) CHECK ([mood_rate] IN ('VERY SAD', 'SAD', 'NORMAL', 'HAPPY', 'VERY HAPPY')),
	[mood_rate_date] DATE DEFAULT GETDATE(),
	[stu_id] BIGINT FOREIGN KEY REFERENCES STUDENT(stu_id)

	CONSTRAINT[MOOD_mood_id] PRIMARY KEY CLUSTERED ([mood_id] ASC)
 );
 --CREATE INDEX mood_index ON MOOD(mood_rate);

IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='ENROLLMENT')
 CREATE TABLE ENROLLMENT(
	[enrollment_id] BIGINT IDENTITY(90400, 1),
	[enrollment_date] DATE DEFAULT GETDATE(),
	[stu_id] BIGINT FOREIGN KEY REFERENCES STUDENT(stu_id),
	[course_id] BIGINT FOREIGN KEY REFERENCES COURSE(course_id)

	CONSTRAINT[ENROLLMENT_enrollment_id] PRIMARY KEY CLUSTERED ([enrollment_id] ASC)
 );
-- CREATE INDEX enrollment_index ON ENROLLMENT(enrollment_date);

IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='COURSE')
 CREATE TABLE COURSE(
	[course_id] BIGINT IDENTITY(10800, 1),
	[course_name] VARCHAR(50) NOT NULL,
	[enrollment_id] BIGINT FOREIGN KEY REFERENCES ENROLLMENT(enrollment_id),
	--[department_id] INTEGER FOREIGN KEY REFERENCES DEPARTMENT(department_id)

	CONSTRAINT[COURSE_course_id] PRIMARY KEY CLUSTERED ([course_id] ASC)
 );
 --CREATE INDEX course_index ON COURSE(course_name);


IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='DEPARTMENT')
 CREATE TABLE DEPARTMENT(
	[department_id] INTEGER IDENTITY(100, 1),
	[department_name] VARCHAR(50) NOT NULL UNIQUE,

    CONSTRAINT[DEPARTMENT_department_id] PRIMARY KEY CLUSTERED ([department_id] ASC)
 );
 --CREATE INDEX department_name ON DEPARTMENT(department_name);


IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='REFERRAL_ADMISSION')
 CREATE TABLE REFERRAL_ADMISSION(
	[ref_admission_id] BIGINT IDENTITY(10200, 1),
	[ref_admission_date] DATE DEFAULT GETDATE(),
	[stu_id] BIGINT FOREIGN KEY REFERENCES STUDENT(stu_id),
	[ref_reason_id] BIGINT FOREIGN KEY REFERENCES REFERRAL_REASON(ref_reason_id)

	CONSTRAINT[REFERRAL_ADMISSION_ref_admission_id] PRIMARY KEY CLUSTERED ([ref_admission_id] ASC)
 );
 --CREATE INDEX ref_admission_index ON REFERRAL_ADMISSION(ref_admission_date);

IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='REFERRAL_REASON')
 CREATE TABLE REFERRAL_REASON(
	[ref_reason_id] BIGINT IDENTITY(6100, 1),
	[ref_reason_name] VARCHAR(50) NOT NULL,
	[ref_reason_description] TEXT NOT NULL,

	CONSTRAINT[REFERRAL_REASON_ref_reason_id] PRIMARY KEY ([ref_reason_id] ASC)
 );
 --CREATE INDEX ref_reason_index ON REFERRAL_REASON(ref_reason_name);
 



IF NOT EXISTS (SELECT * FROM sys.tables t WHERE t.NAME='TESTER')
CREATE TABLE TESTER(
	user_id BIGINT IDENTITY(22200, 1),
	user_fname VARCHAR(20) NOT NULL,
	user_lname VARCHAR(20) NOT NULL,
	user_DOB DATE NOT NULL,
	user_age AS(DATEDIFF(year, user_DOB, GETDATE())),
	user_gender CHAR(1) CHECK(user_gender IN ('M','F')),
	user_signup_date DATETIME DEFAULT GETDATE(),
	user_phone VARCHAR(10) NOT NULL UNIQUE, 
	user_email VARCHAR(50) NOT NULL UNIQUE,
	user_password VARBINARY(200)


	CONSTRAINT [USER_user_index] PRIMARY KEY CLUSTERED([user_id] ASC)
);


SELECT * FROM ADDRESS;
SELECT * FROM STUDENT;
SELECT * FROM COUNSELLOR;
SELECT * FROM ADMINISTRATOR;
SELECT * FROM EVENT;
SELECT * FROM CORE_SERVICE;
SELECT * FROM COMMON_ISSUES;
SELECT * FROM EMERGENCY_RESOURCES;
SELECT * FROM RATING;
SELECT * FROM APPOINTMENT;
SELECT * FROM SESSION;
SELECT * FROM SESSION_NOTE;
SELECT * FROM COMMENT;
SELECT * FROM MOOD;
SELECT * FROM ENROLLMENT;
SELECT * FROM COURSE;
SELECT * FROM DEPARTMENT;
/*
INSERT INTO TESTER(user_fname, user_lname, user_DOB, user_gender, user_phone, user_email, user_password)
VALUES('Gojo', 'Saturo', '1996-12-31', 'M', '0768356329', 'SaturoGojo@jjk.com', CAST('TheStrongest' AS VARBINARY(200)));

SELECT user_id AS USER_ID, user_fname AS FIRSTNAME, user_lname AS LASTNAME, user_DOB AS DATE_OF_BIRTH, user_age AS AGE, 
       user_gender AS GENDER, user_signup_date AS SIGNUP_DATE, user_phone AS PHONE, user_email AS EMAIL_ADDRESS,
	   CAST(user_password AS VARCHAR(200)) AS password
FROM TESTER;

SELECT * FROM TESTER;

SELECT * FROM STUDENT;
SELECT * FROM [ADDRESS];
*/
