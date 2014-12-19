package com.inspur.cams.prs.util;

public class PrsSQL {
	public static final String DELETE_PRS_ATTACHMENT_BY_POLICIESID = "DELETE FROM PRS_ATTACHMENT WHERE POLICIES_REGULATIONS_ID=?"; 
	public static final String SELECT_ATTACHMENT_ID_PRS_ATTACHMENT_BY_POLICIES_REGULATIONS_ID="SELECT ATTACHMENT_ID,FILE_NAME FROM PRS_ATTACHMENT WHERE POLICIES_REGULATIONS_ID=?";
	public static final String SELECT_ATTACHMENT_PRS_ATTACHMENT_BY_ATTACHMENT_ID="SELECT ATTACHMENT FROM PRS_ATTACHMENT WHERE ATTACHMENT_ID= ? AND FILE_NAME=? ";
	public static final String SELECT_PRS_SOLDIERS_PLACEMENT_SOLDIERS_ID="SELECT * FROM PRS_SOLDIERS_PLACEMENT WHERE 1=1 AND SOLDIERS_ID = ?";
	public static final String SELECT_PRS_SOLDIERS_TRAIN_BY_SOLDIERS_ID="SELECT PRS_SOLDIERS_TRAIN.SOLDIERS_ID,PRS_SOLDIERS_TRAIN.TRAIN_ID,PRS_SOLDIERS_TRAIN.TRAINING_END_TIME,PRS_SOLDIERS_TRAIN.WHETHER_VOLUNTARY,PRS_SOLDIERS_TRAIN.TRAINING_INSTITUTIONS,PRS_SOLDIERS_TRAIN.REMARKS,PRS_SOLDIERS_TRAIN.TRAINING_TYPE,PRS_SOLDIERS_TRAIN.CULTURAL_STUDIES_TEST_SCORES,PRS_SOLDIERS_TRAIN.TRAINING_START_TIME,PRS_SOLDIERS_TRAIN.ARCHIVES_PERFORMANCE_SCORES,PRS_SOLDIERS_TRAIN.TOTAL_SCORE,PRS_SOLDIERS_TRAIN.TRAINING_SKILL_LEVEL,PRS_SOLDIERS_TRAIN.TRAINING_MAJOR,PRS_SOLDIERS_TRAIN.RANKING FROM PRS_SOLDIERS_TRAIN WHERE 1=1 AND SOLDIERS_ID = ?";
	public static final String UPDATE_PRS_PROBLEM_HISTORY_BY_PROBLEM_ID="UPDATE PRS_PROBLEM_HISTORY SET DEAL_FLAG='03' WHERE PROBLEM_ID= ? ";
	public static final String DELETE_PRS_POLICIES_REGULATIONS_BY_POLICIES_REGULATIONS_ID="DELETE FROM PRS_POLICIES_REGULATIONS WHERE POLICIES_REGULATIONS_ID=? "; 
	public static final String SELECT_PRS_POLICIES_REGULATIONS="SELECT * FROM PRS_POLICIES_REGULATIONS WHERE 1=1 ";
	public static final String SELECT_PRS_PROBLEM_DEAL="SELECT PROBLEM_ID, PROBLEM_TITLE,PROBLEM_COMPANY, PERSON_NUMBER , ORGAN,SUPERVISION, PROBLEM_FROM, PROBLEM_DATE, DEAL_FLAG,CUR_ACTIVITY FROM PRS_PROBLEM_DEAL   WHERE 1=1 ";
	public static final String SELECT_PRS_PROBLEM_DEAL_PRS_PROBLEM_HISTORY="SELECT D.PROBLEM_ID PROBLEM_ID,D.PROBLEM_TITLE PROBLEM_TITLE,D.PROBLEM_COMPANY PROBLEM_COMPANY,D.PERSON_NUMBER PERSON_NUMBER,D.ORGAN ORGAN,D.SUPERVISION SUPERVISION,'03' PROBLEM_FROM,D.PROBLEM_DATE PROBLEM_DATE,NVL(H.DEAL_FLAG,D.DEAL_FLAG) DEAL_FLAG,D.CUR_ACTIVITY CUR_ACTIVITY FROM PRS_PROBLEM_DEAL D ,PRS_PROBLEM_HISTORY H WHERE 1=1 AND  D.PROBLEM_ID=H.PROBLEM_ID"; 
	public static final String UPDATE_PRS_CATALOGUE_BY_CATALOG_ID =" UPDATE PRS_CATALOGUE T SET T.INSERT_FLAG = '1' WHERE T.CATALOG_ID = ?";
	public static final String UPDATE_TRAINFLAG_BY_SOLDIERS_ID = "UPDATE PRS_RETIRED_SOLDIERS T SET T.TRAININGFLAG = '1'  WHERE T.SOLDIERS_ID =? ";
	public static final String UPDATE_PLACEMENTFLAG_BY_SOLDIERS_ID = "UPDATE PRS_RETIRED_SOLDIERS T SET T.EMPLACEMENTFLAG = '1'  WHERE T.SOLDIERS_ID =? ";
	public static final String SELECT_PEOPLENUMBER="SELECT COUNT(*) AS PEOPLENUMBER FROM PRS_RETIRED_SOLDIERS WHERE 1=1 ";
	public static final String UPDATE_ALLOTFLAG_BY_SOLDIERS_ID= "UPDATE PRS_RETIRED_SOLDIERS T SET T.ALLOT_FLAG = '1'  WHERE T.SOLDIERS_ID = ? "; 
	public static final String SELECT_SOLDIERS_INFO ="SELECT T.SOLDIERS_ID ID,S.TRAINING_MAJOR, T.RETIRED_SOLDIER_TYPE SOLDIERTYPE,T.NAME NAME, T.SEX SEX,T.SERVED_MILITARY_REGION REGION,T.BIRTHDAY BIRTHDAY,T.NATON NATION,T.ENLIST_TIME ENTIME,T.ENLIST_PLACE ENPLACE,SUBSTR(T.RETIRED_TIME,1,4) RETIREDTIMES,T.RETIRED_TIME RETIREDTIME,T.VETERANS_CERTIFICATE_NO CERTIFICATENO,T.WHERE_PLACEMEN WHEREPLACEMENT,T.TEL TEL,T.ADDRESS ADDRESS,T.FLAG FLAG,T.FILES_SOURCE SOURCE,T.SERVICED_TIME SERVICEDTIME,T.SPECIALTY SPEC,T.CONTENT CONTENT,T.FILE_NUM FILENUM,T.SERVED_ARMY SERVEDARMY,T.SPOUSE_LOCATION SLOCATION,T.PLACEMEN_RENSON PRENSON,T.TRANS_FILE TFILE,T.IF_RECEIVE IFRECEIVE,T.RECEIVE_TIME RECEIVETIME,T.NO_RECEIVE_RESON NORECEIVERESON,T.IDCARD_NO,T.HUKOU_TYPE,T.COUTRAL_LEVEL,T.ARRIVE_TIME ";
	public static final String SELECT_SOLDIERS_INFO_WITHOUT_FROM ="SELECT T.SOLDIERS_ID ID, T.RETIRED_SOLDIER_TYPE SOLDIERTYPE,T.NAME NAME, T.SEX SEX,T.SERVED_MILITARY_REGION REGION,T.BIRTHDAY BIRTHDAY,T.NATON NATION,T.ENLIST_TIME ENTIME,T.ENLIST_PLACE ENPLACE,SUBSTR(T.RETIRED_TIME,1,4) RETIREDTIMES,T.RETIRED_TIME RETIREDTIME,T.VETERANS_CERTIFICATE_NO CERTIFICATENO,T.WHERE_PLACEMEN WHEREPLACEMENT,T.TEL TEL,T.ADDRESS ADDRESS,T.FLAG FLAG,T.FILES_SOURCE SOURCE,T.SERVICED_TIME SERVICEDTIME,T.SPECIALTY SPEC,T.CONTENT CONTENT,T.FILE_NUM FILENUM,T.SERVED_ARMY SERVEDARMY,T.SPOUSE_LOCATION SLOCATION,T.PLACEMEN_RENSON PRENSON,T.TRANS_FILE TFILE,T.IF_RECEIVE IFRECEIVE,T.RECEIVE_TIME RECEIVETIME,T.NO_RECEIVE_RESON NORECEIVERESON,T.IDCARD_NO,T.HUKOU_TYPE,T.COUTRAL_LEVEL,T.ARRIVE_TIME ";
	public static final String SELECT_AWARDS_MERITORIOUS_BY_SOLDIER_ID="SELECT * FROM PRS_AWARDS_MERITORIOUS S WHERE S.SOLDIERS_ID = ? ORDER BY S.AWARDS_TIME ";
	public static final String SELECT_ARMY_BY_SOLDIER_ID = "SELECT * FROM PRS_SOLDIERS_ARMY T WHERE T.SOLDIERS_ID = ? "; 
	
	public static final String SELECT_PRS_PROBLEM_DEAL_BY_PROBLEM_ID="SELECT * FROM PRS_PROBLEM_DEAL T WHERE 1=1  AND T.PROBLEM_ID=?";
}