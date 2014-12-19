package com.inspur.cams.sorg.online.base.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.sorg.base.data.SomDuty;
import com.inspur.cams.sorg.online.base.dao.ISomDutyOnlineDao;
import com.inspur.cams.sorg.online.base.data.SomDutyOnline;

/**
 * @title:SomDutyOnlineDao
 * @description:
 * @author:
 * @since:2012-11-08
 * @version:1.0
*/
 public class SomDutyOnlineDao extends EntityDao<SomDutyOnline> implements ISomDutyOnlineDao{

 	public SomDutyOnlineDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
 	
 	public static String SOM_PEOPLE_DUTY = "SELECT D.DUTY_ID,D.TASK_CODE,D.SORG_ID,D.SESSION_ID,D.SORG_DUTIES,D.START_DATE,D.END_DATE,D.PROGRESS,D.IF_RENEW,D.RENEW_NUM,D.IF_SERVE,D.PROMISE_CODE,D.PROMISE_DATE,D.PROMISE_ORGAN,D.BORG_CHECK_DATE,D.BORG_OPINION,D.BORG_NAME,D.WORK_NAME,D.WORK_OPINION,D.WORK_CHECK_DATE,D.SORG_OPINION,D.SORG_CHECK_DATE,D.REG_STATUS,D.MORG_AREA,D.MORG_NAME,D.SORG_TYPE,D.OTHER_DUTIES,P.PEOPLE_ID,P.NAME,P.ALIAS_NAME,P.SEX,P.FOLK,P.BIRTHDAY,P.NATION,P.CARD_TYPE,P.ID_CARD,P.POLITICS,P.EDUCATION,P.POPULACE,P.BIRTHPLACE,P.ADDS,P.POST_CODE,P.PHONE,P.IF_PARTY_LEADER,P.IF_RETIRE,P.WORK_PHONE,P.WORK_DUTIES,P.PROFESSION,P.IF_FULLTIME,P.PEOPLE_PARTY_TYPE,P.JOIN_DATE,P.RELATION,P.PARTY_DUTIES,P.IF_MOBLIE,P.DEVELOP_DATE,P.ACTIVISTS_DATE,P.APPLICATION_DATE,P.RESUME,P.RELATIVE,P.PHOTO_ID,P.NOTE,P.CREATE_PEOPLE,P.CREATE_TIME,P.PERSON_UNIT,P.PERSON_UNIT_PHONE FROM SOM_DUTY_ONLINE D, SOM_PEOPLE_ONLINE P WHERE D.PEOPLE_ID=P.PEOPLE_ID";
 	
  	@Override
	public Class getEntityClass() {
		return SomDutyOnline.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomDutyOnline");
	}
   
   public DataSet queryPeople(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(SOM_PEOPLE_DUTY);
		String idCard=(String)pset.getParameter("ID_CARD");
		String sorgId = (String) pset.getParameter("SORG_ID");
		String sessionId = (String) pset.getParameter("SESSION_ID");
		String ifServe = (String) pset.getParameter("IF_SERVE");
		String peopleId = (String) pset.getParameter("PEOPLE_ID");
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String regStatus = (String) pset.getParameter("REG_STATUS");
		String dutyId = (String) pset.getParameter("DUTY_ID");
		String sorgDuties = (String) pset.getParameter("SORG_DUTIES");
		String sorgDuties2 = (String) pset.getParameter("SORG_DUTIES@in");
		String sorgDuties3 = (String) pset.getParameter("SORG_DUTIES!=");
		String sorgDuties4 = (String) pset.getParameter("SORG_DUTIES@null");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		
		if(regStatus != null && !regStatus.equals("")){
			sql.append(" AND D.REG_STATUS=?");
			typeList.add(Types.VARCHAR);
			objList.add(regStatus);
		}
		if(taskCode != null && !taskCode.equals("")){
			sql.append(" AND D.TASK_CODE=?");
			typeList.add(Types.VARCHAR);
			objList.add(taskCode);
		}
		if(sorgId != null && !sorgId.equals("")){
			sql.append(" AND D.SORG_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(sorgId);
		}
		if(sessionId != null && !sessionId.equals("")){
			sql.append(" AND D.SESSION_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(sessionId);
		}
		if(idCard != null && !idCard.equals("")){
			sql.append(" AND p.ID_CARD=?");
			typeList.add(Types.VARCHAR);
			objList.add(idCard);
		}
		if(ifServe != null && !ifServe.equals("")){
			sql.append(" AND D.IF_SERVE=?");
			typeList.add(Types.VARCHAR);
			objList.add(ifServe);
		}
		if(peopleId != null && !peopleId.equals("")){
			sql.append(" AND D.PEOPLE_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(peopleId);
		}
		if(sorgDuties != null && !sorgDuties.equals("")){
			sql.append(" AND D.SORG_DUTIES=?");
			typeList.add(Types.VARCHAR);
			objList.add(sorgDuties);
		}
		if(dutyId != null && !dutyId.equals("")){
			sql.append(" AND D.DUTY_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(dutyId);
		}
		if(sorgDuties2 != null && !sorgDuties2.equals("")){
			String[] duties = sorgDuties2.split(",");
			sql.append(" AND ( ");
			for (int k = 0; k < duties.length; k++) {
				sql.append(" D.SORG_DUTIES=? ");
				typeList.add(Types.VARCHAR);
				objList.add(duties[k]);
				if(k!=duties.length-1){
					sql.append(" OR ");
				}
			}
			sql.append(" ) ");
		}
		if(sorgDuties3 != null && !sorgDuties3.equals("")){
			String[] duties = sorgDuties3.split(",");
			for (int k = 0; k < duties.length; k++) {
				sql.append(" AND");
				sql.append(" D.SORG_DUTIES!=? ");
				typeList.add(Types.VARCHAR);
				objList.add(duties[k]);
			}
		}
		if(sorgDuties4 != null && !sorgDuties4.equals("")){
			sql.append(" AND D.SORG_DUTIES IS NULL");
		}
		
		sql.append( " ORDER BY D.IF_SERVE DESC");
		DataSet ds = new DataSet();
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		int count = start+limit;
		if(typeList.size()!=0 && objList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int j = 0; j < typeList.size(); j++) {
				types[j]=typeList.get(j);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet ds0 = this.executeDataset(sql.toString(),types,objs,true);
			List<Record> list = ds0.getRecordSet();
			if(count>list.size()){
				count = list.size();
			}
			for (int i = start; i < count; i++) {
				Record rd = (Record) list.get(i);
				SomDuty somDuty = new SomDuty();
				//人员信息
				somDuty.setPeopleId((String) rd.get("PEOPLE_ID"));
				somDuty.setName((String) rd.get("NAME"));
				somDuty.setAliasName((String) rd.get("ALIAS_NAME"));
				somDuty.setSex((String) rd.get("SEX"));
				somDuty.setFolk((String) rd.get("FOLK"));
				somDuty.setBirthday((String) rd.get("BIRTHDAY"));
				somDuty.setNation((String) rd.get("NATION"));
				somDuty.setCardType((String) rd.get("CARD_TYPE"));
				somDuty.setIdCard((String) rd.get("ID_CARD"));
				somDuty.setPolitics((String) rd.get("POLITICS"));
				somDuty.setEducation((String) rd.get("EDUCATION"));
				somDuty.setPopulace((String) rd.get("POPULACE"));
				somDuty.setBirthplace((String) rd.get("BIRTHPLACE"));
				somDuty.setAdds((String) rd.get("ADDS"));
				somDuty.setPostCode((String) rd.get("POST_CODE"));
				somDuty.setPhone((String) rd.get("PHONE"));
				somDuty.setIfPartyLeader((String) rd.get("IF_PARTY_LEADER"));
				somDuty.setIfRetire((String) rd.get("IF_RETIRE"));
				somDuty.setWorkName((String) rd.get("WORK_NAME"));
				somDuty.setWorkPhone((String) rd.get("WORK_PHONE"));
				somDuty.setWorkDuties((String) rd.get("WORK_DUTIES"));
				somDuty.setProfession((String) rd.get("PROFESSION"));
				somDuty.setIfFulltime((String) rd.get("IF_FULLTIME"));
				somDuty.setPeoplePartyType((String) rd.get("PEOPLE_PARTY_TYPE"));
				somDuty.setJoinDate((String) rd.get("JOIN_DATE"));
				somDuty.setRelation((String) rd.get("RELATION"));
				somDuty.setPartyDuties((String) rd.get("PARTY_DUTIES"));
				somDuty.setIfMoblie((String) rd.get("IF_MOBLIE"));
				somDuty.setDevelopDate((String) rd.get("DEVELOP_DATE"));
				somDuty.setActivistsDate((String) rd.get("ACTIVISTS_DATE"));
				somDuty.setApplicationDate((String) rd.get("APPLICATION_DATE"));
				somDuty.setResume((String) rd.get("RESUME"));
				somDuty.setIfLegal("0");//取出来的数据这个字段一律为否
				somDuty.setRelative((String) rd.get("RELATIVE"));
				somDuty.setPhotoId((String) rd.get("PHOTO_ID"));
				somDuty.setNote((String) rd.get("NOTE"));
				somDuty.setCreatePeople((String) rd.get("CREATE_PEOPLE"));
				somDuty.setCreateTime((String) rd.get("CREATE_TIME"));
				somDuty.setPersonUnit((String) rd.get("PERSON_UNIT"));
				somDuty.setPersonUnitPhone((String) rd.get("PERSON_UNIT_PHONE"));
				//任职信息
				somDuty.setDutyId((String) rd.get("DUTY_ID"));
				somDuty.setTaskCode((String) rd.get("TASK_CODE"));
				somDuty.setSorgId((String) rd.get("SORG_ID"));
				somDuty.setSessionId((String) rd.get("SESSION_ID"));
				somDuty.setSorgDuties((String) rd.get("SORG_DUTIES"));
				somDuty.setStartDate((String) rd.get("START_DATE"));
				somDuty.setEndDate((String) rd.get("END_DATE"));
				somDuty.setProgress((String) rd.get("PROGRESS"));
				somDuty.setIfRenew((String) rd.get("IF_RENEW"));
				somDuty.setRenewNum((String) rd.get("RENEW_NUM"));
				somDuty.setIfServe((String) rd.get("IF_SERVE"));
				somDuty.setPromiseCode((String) rd.get("PROMISE_CODE"));
				somDuty.setPromiseDate((String) rd.get("PROMISE_DATE"));
				somDuty.setPromiseOrgan((String) rd.get("PROMISE_ORGAN"));
				somDuty.setBorgCheckDate((String) rd.get("BORG_CHECK_DATE"));
				somDuty.setBorgOpinion((String) rd.get("BORG_OPINION"));
				somDuty.setBorgName((String) rd.get("BORG_NAME"));
				somDuty.setWorkName((String) rd.get("WORK_NAME"));
				somDuty.setWorkOpinion((String) rd.get("WORK_OPINION"));
				somDuty.setWorkCheckDate((String) rd.get("WORK_CHECK_DATE"));
				somDuty.setSorgOpinion((String) rd.get("SORG_OPINION"));
				somDuty.setSorgCheckDate((String) rd.get("SORG_CHECK_DATE"));
				somDuty.setRegStatus((String) rd.get("REG_STATUS"));
				somDuty.setMorgArea((String) rd.get("MORG_AREA"));
				somDuty.setMorgName((String) rd.get("MORG_NAME"));
				somDuty.setSorgType((String) rd.get("SORG_TYPE"));//社会组织类型
				somDuty.setOtherDuties((String) rd.get("OTHER_DUTIES"));
				ds.addRecord(somDuty);
			}
			ds.setTotalCount(list.size());
		}
		return ds;
	}
   
}
