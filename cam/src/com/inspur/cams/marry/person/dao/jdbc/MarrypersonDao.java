package com.inspur.cams.marry.person.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.person.dao.IMarrypersonDao;
import com.inspur.cams.marry.person.data.Marryperson;

/**
 * @title: MarrypersonDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrypersonDao extends EntityDao<Marryperson> implements IMarrypersonDao {

	public MarrypersonDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class<Marryperson> getEntityClass() {
		return Marryperson.class;
	}
	
	public DataSet queryMarryPersons(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT PERSON.technical, PERSON.PERSON_ID,PERSON.NAME,PERSON.SEX,");
		sql.append("GETAGE_CARD_NO(PERSON.CARD_NO) AGE,PERSON.WORKSTATE,");
		sql.append("PERSON.CARD_NO,PERSON.CULTURE,PERSON.POLITICS,");
		sql.append("(SELECT INFO.NAME FROM MRM_REGIS_ORGAN_INFO INFO ");
		sql.append("WHERE INFO.DEPT_CODE =  PERSON.DEPT_ID ) DEPT ,");
		sql.append("PERSON.KIND ORGANIZATION,PERSON.DUTY,");
		sql.append("PERSON.MARRY_START_DATE,PERSON.MARRY_END_DATE,PERSON.CERTIFICATE_ID,");
		sql.append("FIRSTEXAM.FIRST_TIME,FIRSTEXAM.FIRST_JG,FIRSTEXAM.FRIST_BKJG,");
		sql.append("LASTEXAM.LAST_TIME,LASTEXAM.LAST_JG,LASTEXAM.LAST_BKJG,");
		sql.append("LASTEXAM.AUTOMATIC_FAILURE_TIME,LASTEXAM.BACKOUT_TIME,");
		sql.append("TO_CHAR(PERSON.DEPARTURE_TEME, 'YYYY-MM-DD') DEPARTURE_TIME,");
		sql.append(" PERSON.DEPARTURE_REASON  FROM MRM_BASE_PERSON PERSON ");
		sql.append(" left JOIN (SELECT EXAM_FIRST.PERSON_ID, EXAM_FIRST.KSSJ_TIME FIRST_TIME, ");
		sql.append("EXAM_FIRST.KSJG FIRST_JG,EXAM_FIRST.BKJG FRIST_BKJG");
		sql.append(" FROM MRM_QUALIFICATION_EXAM EXAM_FIRST WHERE EXAM_FIRST.CKFKBZ = '01')");
		sql.append("FIRSTEXAM ON FIRSTEXAM.PERSON_ID = PERSON.PERSON_ID ");
		sql.append(" left JOIN (SELECT EXAM.PERSON_ID,EXAM.KSSJ_TIME LAST_TIME,");
		sql.append("EXAM.KSJG LAST_JG, EXAM.BKJG LAST_BKJG,EXAM.AUTOMATIC_FAILURE_TIME,");
		sql.append("EXAM.BACKOUT_TIME FROM MRM_QUALIFICATION_EXAM EXAM");
		sql.append(" WHERE EXAM.CKFKBZ = '02' AND EXAM.KSSJ_TIME =");
		sql.append("(SELECT TO_CHAR(MAX(TO_DATE(KSSJ_TIME, 'YYYY-MM-DD')),'YYYY-MM-DD')");
		sql.append(" FROM MRM_QUALIFICATION_EXAM T WHERE T.PERSON_ID = EXAM.PERSON_ID");
		
		String queryWorkState = (String)pset.getParameter("queryWorkState");//岗位状态
		String queryAge = (String)pset.getParameter("queryAge");//年龄
		
		String ksjg = (String) pset.getParameter("ksjg");//考试结果
		if(ksjg!=null&&!"null".equals(ksjg)){
			sql.append(" AND EXAM.KSJG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(ksjg);
		}
		
		String bkjg = (String) pset.getParameter("bkjg");
		if(bkjg!=null&&!"null".equals(bkjg)){
			sql.append(" AND EXAM.BKJG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(bkjg);
		}
		sql.append(" ))  LASTEXAM ON LASTEXAM.PERSON_ID =PERSON.PERSON_ID ");
		sql.append(" WHERE 1 = 1 ");
		
		String deptId = (String) pset.getParameter("deptId");
		if(deptId!=null&&!"null".equals(deptId) && !"".equals(deptId)){
			if("0001".equals(deptId.substring(4))) { //市级婚姻事务处或者管理处
				sql.append(" AND substr(PERSON.DEPT_ID,1,4) = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(deptId.substring(0,4));
			} else {
				sql.append(" AND PERSON.DEPT_ID = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(deptId);
			}
		}
		
		String name = (String) pset.getParameter("name");
		if(name!=null&&!"null".equals(name)){
			sql.append(" AND PERSON.NAME like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		String technical = (String) pset.getParameter("technical");
		if(technical!=null&&!"null".equals(technical)){
			sql.append(" AND PERSON.technical = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(technical);
		}
		
		String duty = (String) pset.getParameter("duty");
		if(duty!=null&&!"null".equals(duty)){
			sql.append(" AND PERSON.DUTY = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(duty);
		}
		
		String startTime = (String) pset.getParameter("startTime");
		if(startTime!=null&&!"null".equals(startTime)){
			sql.append(" AND substr(PERSON.MARRY_START_DATE,1,4) <= ? AND substr( PERSON.MARRY_END_DATE,1,4) >= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
		}
		
		String startYear = (String) pset.getParameter("startYear");
		if(startYear!=null&&!"null".equals(startYear)){
			sql.append(" AND substr(PERSON.MARRY_START_DATE,1,4) = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(startYear);
		}
		
		String sex = (String) pset.getParameter("sex");//性别
		if(sex!=null&&!"null".equals(sex)){
			sql.append(" AND PERSON.SEX = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sex);
		}
		String culture = (String) pset.getParameter("culture");//文化程度
		if(culture!=null&&!"null".equals(culture)){
			sql.append(" AND PERSON.CULTURE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(culture);
		}
		String politics = (String) pset.getParameter("politics");//政治面貌
		if(politics!=null&&!"null".equals(politics)){
			sql.append(" AND PERSON.POLITICS = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(politics);
		}
		String kind = (String) pset.getParameter("kind");//编制性质
		if(kind!=null&&!"null".equals(kind)){
			sql.append(" AND PERSON.KIND = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(kind);
		}
		
		if(queryWorkState != null && !"".equals(queryWorkState)) { //岗位状态
			sql.append(" AND PERSON.WORKSTATE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(queryWorkState);
		}
		
		if(queryAge != null && !"".equals(queryAge)) { //年龄
			sql.append(" AND GETAGE_CARD_NO(PERSON.CARD_NO) = ? ");
			typeList.add(Types.INTEGER);
			argsList.add(queryAge);
		}
		
		sql.append(" and PERSON.name not like '%婚姻%' ORDER BY PERSON.DEPT_ID,PERSON.WORKSTATE,PERSON.CERTIFICATE_ID  ASC");
		int[] types = new int[typeList.size()];
		for(int i =0;i<typeList.size();i++){
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		return executeDataset(sql.toString(),types,args,getDsStart(pset), getDsLimit(pset),true);
	}
	
	public DataSet queryCertifierPersons(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append("SELECT PERSON.technical, PERSON.PERSON_ID,PERSON.NAME,PERSON.SEX,");
		sql.append("GETAGE_CARD_NO(PERSON.CARD_NO) AGE,PERSON.WORKSTATE,");
		sql.append("PERSON.CARD_NO,PERSON.CULTURE,PERSON.POLITICS,");
		sql.append("(SELECT INFO.NAME FROM MRM_REGIS_ORGAN_INFO INFO ");
		sql.append("WHERE INFO.DEPT_CODE =  PERSON.DEPT_ID ) DEPT ,");
		sql.append("PERSON.KIND ORGANIZATION,PERSON.DUTY,");
		sql.append("PERSON.MARRY_START_DATE,PERSON.CERTIFICATE_ID,");
		sql.append("FIRSTEXAM.FIRST_TIME,FIRSTEXAM.FIRST_JG,FIRSTEXAM.FRIST_BKJG,");
		sql.append("LASTEXAM.LAST_TIME,LASTEXAM.LAST_JG,LASTEXAM.LAST_BKJG,");
		sql.append("LASTEXAM.AUTOMATIC_FAILURE_TIME,LASTEXAM.BACKOUT_TIME,");
		sql.append("TO_CHAR(PERSON.DEPARTURE_TEME, 'YYYY-MM-DD') DEPARTURE_TIME,");
		sql.append(" PERSON.DEPARTURE_REASON  FROM MRM_BASE_PERSON PERSON ");
		sql.append(" left JOIN (SELECT EXAM_FIRST.PERSON_ID, EXAM_FIRST.KSSJ_TIME FIRST_TIME, ");
		sql.append("EXAM_FIRST.KSJG FIRST_JG,EXAM_FIRST.BKJG FRIST_BKJG");
		sql.append(" FROM MRM_QUALIFICATION_EXAM EXAM_FIRST WHERE EXAM_FIRST.CKFKBZ = '01')");
		sql.append("FIRSTEXAM ON FIRSTEXAM.PERSON_ID = PERSON.PERSON_ID ");
		sql.append(" left JOIN (SELECT EXAM.PERSON_ID,EXAM.KSSJ_TIME LAST_TIME,");
		sql.append("EXAM.KSJG LAST_JG, EXAM.BKJG LAST_BKJG,EXAM.AUTOMATIC_FAILURE_TIME,");
		sql.append("EXAM.BACKOUT_TIME FROM MRM_QUALIFICATION_EXAM EXAM");
		sql.append(" WHERE EXAM.CKFKBZ = '02' AND EXAM.KSSJ_TIME =");
		sql.append("(SELECT TO_CHAR(MAX(TO_DATE(KSSJ_TIME, 'YYYY-MM-DD')),'YYYY-MM-DD')");
		sql.append(" FROM MRM_QUALIFICATION_EXAM T WHERE T.PERSON_ID = EXAM.PERSON_ID");
		String ksjg = (String) pset.getParameter("ksjg");//考试结果
		if(ksjg!=null&&!"null".equals(ksjg)){
			sql.append(" AND EXAM.KSJG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(ksjg);
		}
		
		String bkjg = (String) pset.getParameter("bkjg");
		if(bkjg!=null&&!"null".equals(bkjg)){
			sql.append(" AND EXAM.BKJG = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(bkjg);
		}
		sql.append(" ))  LASTEXAM ON LASTEXAM.PERSON_ID =PERSON.PERSON_ID ");
		sql.append(" WHERE 1 = 1 AND  PERSON.BZY_CODE = '02' ");
		String deptId = (String) pset.getParameter("deptId");
		if(deptId!=null&&!"null".equals(deptId) && !"".equals(deptId)){
			if("0001".equals(deptId.substring(4))) { //市级婚姻事务处或者管理处
				sql.append(" AND substr(PERSON.DEPT_ID,1,4) = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(deptId.substring(0,4));
			} else {
				sql.append(" AND PERSON.DEPT_ID = ? ");
				typeList.add(Types.VARCHAR);
				argsList.add(deptId);
			}
		}
		String name = (String) pset.getParameter("name");
		if(name!=null&&!"null".equals(name)){
			sql.append(" AND PERSON.NAME like '%'||?||'%' ");
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		String technical = (String) pset.getParameter("technical");
		if(technical!=null&&!"null".equals(technical)){
			sql.append(" AND PERSON.technical = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(technical);
		}
		
		String duty = (String) pset.getParameter("duty");
		if(duty!=null&&!"null".equals(duty)){
			sql.append(" AND PERSON.DUTY = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(duty);
		}
		
		String startTime = (String) pset.getParameter("startTime");
		if(startTime!=null&&!"null".equals(startTime)){
			sql.append(" AND PERSON.MARRY_START_DATE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(startTime);
		}
		
		String startYear = (String) pset.getParameter("startYear");
		if(startYear!=null&&!"null".equals(startYear)){
			sql.append(" AND substr(PERSON.BZY_BEGINTIME,1,4) = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(startYear);
		}
		
		String sex = (String) pset.getParameter("sex");//性别
		if(sex!=null&&!"null".equals(sex)){
			sql.append(" AND PERSON.SEX = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(sex);
		}
		String culture = (String) pset.getParameter("culture");//文化程度
		if(culture!=null&&!"null".equals(culture)){
			sql.append(" AND PERSON.CULTURE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(culture);
		}
		String politics = (String) pset.getParameter("politics");//政治面貌
		if(politics!=null&&!"null".equals(politics)){
			sql.append(" AND PERSON.POLITICS = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(politics);
		}
		String kind = (String) pset.getParameter("kind");//编制性质
		if(kind!=null&&!"null".equals(kind)){
			sql.append(" AND PERSON.KIND = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(kind);
		}
		sql.append(" ORDER BY PERSON.DEPT_ID,PERSON.WORKSTATE,PERSON.CERTIFICATE_ID  ASC");
		int[] types = new int[typeList.size()];
		for(int i =0;i<typeList.size();i++){
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();
		return executeDataset(sql.toString(),types,args,getDsStart(pset), getDsLimit(pset),true);
	}
	
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
	
}
