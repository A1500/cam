package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.sorg.base.dao.ISomDutyDao;
import com.inspur.cams.sorg.base.data.SomDuty;

/**
 * 社会组织任职信息Dao
 * @author yanliangliang
 * @date 2011-9-22
 */
public class SomDutyDao extends EntityDao<SomDuty> implements ISomDutyDao {
	
	public static String SOM_PEOPLE_DUTY = "SELECT D.DUTY_ID,D.TASK_CODE,D.SORG_ID,D.SESSION_ID,D.SORG_DUTIES,D.START_DATE,D.END_DATE,D.PROGRESS,D.IF_RENEW,D.RENEW_NUM,D.IF_SERVE,D.PROMISE_CODE,D.PROMISE_DATE,D.PROMISE_ORGAN,D.BORG_CHECK_DATE,D.BORG_OPINION,D.BORG_NAME,D.WORK_NAME,D.WORK_OPINION,D.WORK_CHECK_DATE,D.SORG_OPINION,D.SORG_CHECK_DATE,D.REG_STATUS,D.MORG_AREA,D.MORG_NAME,D.SORG_TYPE,D.OTHER_DUTIES,P.PEOPLE_ID,P.NAME,P.ALIAS_NAME,P.SEX,P.FOLK,P.BIRTHDAY,P.NATION,P.CARD_TYPE,P.ID_CARD,P.POLITICS,P.EDUCATION,P.POPULACE,P.BIRTHPLACE,P.ADDS,P.POST_CODE,P.PHONE,P.IF_PARTY_LEADER,P.IF_RETIRE,P.WORK_PHONE,P.WORK_DUTIES,P.PROFESSION,P.IF_FULLTIME,P.PEOPLE_PARTY_TYPE,P.JOIN_DATE,P.RELATION,P.PARTY_DUTIES,P.IF_MOBLIE,P.DEVELOP_DATE,P.ACTIVISTS_DATE,P.APPLICATION_DATE,P.RESUME,P.RELATIVE,P.PHOTO_ID,P.NOTE,P.CREATE_PEOPLE,P.CREATE_TIME,P.PERSON_UNIT,P.PERSON_UNIT_PHONE,P.PARTY_LEADER_LEVEL FROM SOM_DUTY D, SOM_PEOPLE P WHERE D.PEOPLE_ID=P.PEOPLE_ID";
	public static String QUERY_TOGETHER = "SELECT P.NAME,P.ID_CARD,P.SEX,P.BIRTHDAY,P.POLITICS,P.PHONE,P.IF_RETIRE,P.ADDS,P.PEOPLE_ID FROM SOM_PEOPLE P "+" WHERE P.PEOPLE_ID IN ("+"SELECT P.PEOPLE_ID FROM SOM_DUTY D, SOM_PEOPLE P, SOM_SESSION S, SOM_ORGAN O WHERE D.PEOPLE_ID = P.PEOPLE_ID AND D.SESSION_ID = S.SESSION_ID AND D.SORG_ID = O.SORG_ID ";
	public static String QUERY_DUTY_INFO = "SELECT O.CN_NAME,O.SORG_ID, O.SORG_TYPE, D.SORG_DUTIES FROM SOM_DUTY D, SOM_PEOPLE P, SOM_SESSION S, SOM_ORGAN O WHERE D.PEOPLE_ID = P.PEOPLE_ID AND D.SESSION_ID = S.SESSION_ID AND D.SORG_ID = O.SORG_ID";
	public static String CHANGE_SESSION = "UPDATE SOM_DUTY SET END_DATE=?, IF_SERVE='0',REG_STATUS='2' WHERE SESSION_ID=? AND IF_SERVE='1'";
	public static String DELETE_DUTY = "DELETE FROM SOM_DUTY D ";
	public static String DELETE_SESSION = "DELETE FROM SOM_SESSION A ";
	public static String DELETE_RESUME = "DELETE FROM SOM_PEOPLE_RESUME A ";
	public static String DELETE_ELECTRONIC = "DELETE FROM SOM_ELECTRONIC A ";
	public static String UPDATE_REG_STATUS = "UPDATE SOM_DUTY A SET A.REG_STATUS=? WHERE A.TASK_CODE=?";
	public static String QURTY_DUTY_BY_NAME = "SELECT D.DUTY_ID,D.TASK_CODE,D.SORG_ID,D.SESSION_ID,D.SORG_DUTIES,D.START_DATE,D.END_DATE,D.PROGRESS,D.IF_RENEW,D.RENEW_NUM,D.IF_SERVE,D.PROMISE_CODE,D.PROMISE_DATE,D.PROMISE_ORGAN,D.BORG_CHECK_DATE,D.BORG_OPINION,D.BORG_NAME,D.WORK_NAME,D.WORK_OPINION,D.WORK_CHECK_DATE,D.SORG_OPINION,D.SORG_CHECK_DATE,D.REG_STATUS,D.MORG_AREA,D.MORG_NAME,D.SORG_TYPE,D.OTHER_DUTIES,P.PEOPLE_ID,P.NAME,P.ALIAS_NAME,P.SEX,P.FOLK,P.BIRTHDAY,P.NATION,P.CARD_TYPE,P.ID_CARD,P.POLITICS,P.EDUCATION,P.POPULACE,P.BIRTHPLACE,P.ADDS,P.POST_CODE,P.PHONE,P.IF_PARTY_LEADER,P.IF_RETIRE,P.WORK_PHONE,P.WORK_DUTIES,P.PROFESSION,P.IF_FULLTIME,P.PEOPLE_PARTY_TYPE,P.JOIN_DATE,P.RELATION,P.PARTY_DUTIES,P.IF_MOBLIE,P.DEVELOP_DATE,P.ACTIVISTS_DATE,P.APPLICATION_DATE,P.RESUME,P.RELATIVE,P.PHOTO_ID,P.NOTE,P.CREATE_PEOPLE,P.CREATE_TIME,P.PERSON_UNIT,P.PERSON_UNIT_PHONE,P.PARTY_LEADER_LEVEL FROM SOM_DUTY D,SOM_PEOPLE P WHERE P.NAME=? AND P.PEOPLE_ID=D.PEOPLE_ID AND D.IF_SERVE='1' AND D.SORG_ID=?";
	public static String QURTY_CHANGED_LEGAL_DUTY_BY_NAME = "SELECT D.DUTY_ID,D.TASK_CODE,D.SORG_ID,D.SESSION_ID,D.SORG_DUTIES,D.START_DATE,D.END_DATE,D.PROGRESS,D.IF_RENEW,D.RENEW_NUM,D.IF_SERVE,D.PROMISE_CODE,D.PROMISE_DATE,D.PROMISE_ORGAN,D.BORG_CHECK_DATE,D.BORG_OPINION,D.BORG_NAME,D.WORK_NAME,D.WORK_OPINION,D.WORK_CHECK_DATE,D.SORG_OPINION,D.SORG_CHECK_DATE,D.REG_STATUS,D.MORG_AREA,D.MORG_NAME,D.SORG_TYPE,D.OTHER_DUTIES,P.PEOPLE_ID,P.NAME,P.ALIAS_NAME,P.SEX,P.FOLK,P.BIRTHDAY,P.NATION,P.CARD_TYPE,P.ID_CARD,P.POLITICS,P.EDUCATION,P.POPULACE,P.BIRTHPLACE,P.ADDS,P.POST_CODE,P.PHONE,P.IF_PARTY_LEADER,P.IF_RETIRE,P.WORK_PHONE,P.WORK_DUTIES,P.PROFESSION,P.IF_FULLTIME,P.PEOPLE_PARTY_TYPE,P.JOIN_DATE,P.RELATION,P.PARTY_DUTIES,P.IF_MOBLIE,P.DEVELOP_DATE,P.ACTIVISTS_DATE,P.APPLICATION_DATE,P.RESUME,P.RELATIVE,P.PHOTO_ID,P.NOTE,P.CREATE_PEOPLE,P.CREATE_TIME,P.PERSON_UNIT,P.PERSON_UNIT_PHONE,P.PARTY_LEADER_LEVEL FROM SOM_DUTY D,SOM_PEOPLE P WHERE P.NAME=? AND P.PEOPLE_ID=D.PEOPLE_ID AND SORG_STATUS='00012' AND D.IF_SERVE='0' AND D.SORG_ID=?";
	@Override
	protected Class<SomDuty> getEntityClass() {
		return SomDuty.class;
	}

	@SuppressWarnings("unchecked")
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
				sql.append(" NVL(D.SORG_DUTIES,'------------')<>? ");
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
			if(count == -2){
				start = 0;
				count= list.size();
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
				somDuty.setPartyLeaderLevel((String) rd.get("PARTY_LEADER_LEVEL"));
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
	
	/**
	 * 综合查询人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryTogether(ParameterSet pset) {
		String name=(String)pset.getParameter("name");
		String cardType=(String)pset.getParameter("cardType");
		String idCard=(String)pset.getParameter("idCard");
		String sex=(String)pset.getParameter("sex");
		String birthdayQ=(String)pset.getParameter("birthdayQ");
		String birthdayZ=(String)pset.getParameter("birthdayZ");
		String folk=(String)pset.getParameter("folk");
		String nation=(String)pset.getParameter("nation");
		String politics=(String)pset.getParameter("politics");
		String education=(String)pset.getParameter("education");
		String populace=(String)pset.getParameter("populace");
		String ifRetire=(String)pset.getParameter("ifRetire");
		String ifFulltime=(String)pset.getParameter("ifFulltime");
		String workName=(String)pset.getParameter("workName");
		String workPhone=(String)pset.getParameter("workPhone");
		String workDuties=(String)pset.getParameter("workDuties");
		String adds=(String)pset.getParameter("adds");
		String postCode=(String)pset.getParameter("postCode");
		String phone=(String)pset.getParameter("phone");
		
		String cnName = (String) pset.getParameter("cnName");
		String sorgType = (String) pset.getParameter("sorgType");
		String sorgKind = (String) pset.getParameter("sorgKind");
		String ifServe = (String) pset.getParameter("ifServe");
		String sorgDuties = (String) pset.getParameter("sorgDuties");
		String morgName = (String) pset.getParameter("morgName");
		String ifPartyLeader = (String) pset.getParameter("ifPartyLeader");
		String partyLeaderLevel = (String) pset.getParameter("partyLeaderLevel");
		String promiseOrgan = (String) pset.getParameter("promiseOrgan");
		
		String peopleId = (String) pset.getParameter("peopleId");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append(QUERY_TOGETHER);
		if (name != null && !"".equals(name)) {
			sql.append(" AND P.NAME=? ");
			typeList.add(Types.VARCHAR);
			argList.add(name);
		}
		if (cardType != null && !"".equals(cardType)) {
			sql.append(" AND P.CARD_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(cardType);
		}
		if (idCard != null && !"".equals(idCard)) {
			sql.append(" AND P.ID_CARD=? ");
			typeList.add(Types.VARCHAR);
			argList.add(idCard);
		}
		if (sex != null && !"".equals(sex)) {
			sql.append(" AND P.SEX=? ");
			typeList.add(Types.VARCHAR);
			argList.add(sex);
		}
		if (birthdayQ != null && !"".equals(birthdayQ)) {
			sql.append(" AND P.BIRTHDAY>=? ");
			typeList.add(Types.VARCHAR);
			argList.add(birthdayQ);
		}
		if (birthdayZ != null && !"".equals(birthdayZ)) {
			sql.append(" AND P.BIRTHDAY<=? ");
			typeList.add(Types.VARCHAR);
			argList.add(birthdayZ);
		}		
		if (folk != null && !"".equals(folk)) {
			sql.append(" AND P.FOLK=? ");
			typeList.add(Types.VARCHAR);
			argList.add(folk);
		}
		if (nation != null && !"".equals(nation)) {
			sql.append(" AND P.NATION=? ");
			typeList.add(Types.VARCHAR);
			argList.add(nation);
		}
		if (politics != null && !"".equals(politics)) {
			sql.append(" AND P.POLITICS=? ");
			typeList.add(Types.VARCHAR);
			argList.add(politics);
		}
		if (education != null && !"".equals(education)) {
			sql.append(" AND P.EDUCATION=? ");
			typeList.add(Types.VARCHAR);
			argList.add(education);
		}
		if (populace != null && !"".equals(populace)) {
			sql.append(" AND P.POPULACE LIKE ? ");
			typeList.add(Types.VARCHAR);
			argList.add("%"+populace+"%");
		}
		if (ifRetire != null && !"".equals(ifRetire)) {
			sql.append(" AND P.IF_RETIRE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(ifRetire);
		}
		if (ifFulltime != null && !"".equals(ifFulltime)) {
			sql.append(" AND P.IF_FULLTIME=? ");
			typeList.add(Types.VARCHAR);
			argList.add(ifFulltime);
		}
		if (workName != null && !"".equals(workName)) {
			sql.append(" AND P.WORK_NAME LIKE ? ");
			typeList.add(Types.VARCHAR);
			argList.add("%"+workName+"%");
		}
		if (workPhone != null && !"".equals(workPhone)) {
			sql.append(" AND P.WORK_PHONE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(workPhone);
		}
		if (workDuties != null && !"".equals(workDuties)) {
			sql.append(" AND P.WORK_DUTIES=? ");
			typeList.add(Types.VARCHAR);
			argList.add(workDuties);
		}
		if (adds != null && !"".equals(adds)) {
			sql.append(" AND P.ADDS LIKE ? ");
			typeList.add(Types.VARCHAR);
			argList.add("%"+adds+"%");
		}
		if (postCode != null && !"".equals(postCode)) {
			sql.append(" AND P.POST_CODE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(postCode);
		}
		if (phone != null && !"".equals(phone)) {
			sql.append(" AND P.PHONE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(phone);
		}
		
		if (cnName != null && !"".equals(cnName)) {
			sql.append(" AND O.CN_NAME LIKE ? ");
			typeList.add(Types.VARCHAR);
			argList.add("%"+cnName+"%");
		}
		if (sorgType != null && !"".equals(sorgType)) {
			sql.append(" AND O.SORG_TYPE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(sorgType);
		}
		if (sorgKind != null && !"".equals(sorgKind)) {
			sql.append(" AND O.SORG_KIND=? ");
			typeList.add(Types.VARCHAR);
			argList.add(sorgKind);
		}
		if (ifServe != null && !"".equals(ifServe)) {
			sql.append(" AND D.IF_SERVE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(ifServe);
		}
		if (sorgDuties != null && !"".equals(sorgDuties)) {
			sql.append(" AND D.SORG_DUTIES=? ");
			typeList.add(Types.VARCHAR);
			argList.add(sorgDuties);
		}
		if (morgName != null && !"".equals(morgName)) {
			sql.append(" AND O.MORG_NAME=? ");
			typeList.add(Types.VARCHAR);
			argList.add(morgName);
		}		
		
		if (peopleId != null && !"".equals(peopleId)) {
			sql.append(" AND P.PEOPLE_ID=? ");
			typeList.add(Types.VARCHAR);
			argList.add(peopleId);
		}
		if (ifPartyLeader != null && !"".equals(ifPartyLeader)) {
			sql.append(" AND P.IF_PARTY_LEADER=? ");
			typeList.add(Types.VARCHAR);
			argList.add(ifPartyLeader);
		}
		if (partyLeaderLevel != null && !"".equals(partyLeaderLevel)) {
			sql.append(" AND P.PARTY_LEADER_LEVEL=? ");
			typeList.add(Types.VARCHAR);
			argList.add(partyLeaderLevel);
		}
		if (promiseOrgan != null && !"".equals(promiseOrgan)) {
			sql.append(" AND D.PROMISE_ORGAN=? ");
			typeList.add(Types.VARCHAR);
			argList.add(promiseOrgan);
		}
		sql.append(" GROUP BY P.PEOPLE_ID) ORDER BY P.NAME ");
		if(typeList.size()==argList.size() && typeList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argList.toArray(new Object[argList.size()]);
			if (pset.getPageStart() < 0 || pset.getPageLimit() < 0) {
				return executeDataset(sql.toString(),types, args, true);
			} else {
				return executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
			}
		}else{
			if (pset.getPageStart() < 0 || pset.getPageLimit() < 0) {
				return executeDataset(sql.toString(), true);
			} else {
				return executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
			}
		}
	}
	
	/**
	 * 查询任职信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryDutyInfo(ParameterSet pset) {
		String peopleId=(String)pset.getParameter("PEOPLE_ID");
		String ifServe = (String) pset.getParameter("IF_SERVE");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append(QUERY_DUTY_INFO);
		if (peopleId != null && !"".equals(peopleId)) {
			sql.append(" AND P.PEOPLE_ID=? ");
			typeList.add(Types.VARCHAR);
			argList.add(peopleId);
		}
		if (ifServe != null && !"".equals(ifServe)) {
			sql.append(" AND D.IF_SERVE=? ");
			typeList.add(Types.VARCHAR);
			argList.add(ifServe);
		}
		if(typeList.size()==argList.size() && typeList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = typeList.get(i);
			}
			Object[] args = argList.toArray(new Object[argList.size()]);
			return executeDataset(sql.toString(), types, args, true);
		}else{
			return executeDataset(sql.toString(), true);
		}
	}
	
	public void changeSession(String sessionId, String endDate) {
		int[] types = new int[] {Types.VARCHAR, Types.VARCHAR};
		Object[] objs = new Object[] {endDate, sessionId};
		executeUpdate(CHANGE_SESSION, types, objs);
	}
	public void deleteDuty(String taskCode) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_DUTY);
		if(taskCode != null && !"".equals(taskCode)){
			sql.append(" WHERE D.TASK_CODE=?");
			int[] types = new int[] {Types.VARCHAR};
			Object[] objs = new Object[] {taskCode};
			executeUpdate(sql.toString(), types, objs);
		}
	}
	public void deleteSessionByTaskCode(String taskCode) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_SESSION);
		if(taskCode != null && !"".equals(taskCode)){
			sql.append(" WHERE A.TASK_CODE=?");
			int[] types = new int[] {Types.VARCHAR};
			Object[] objs = new Object[] {taskCode};
			executeUpdate(sql.toString(), types, objs);
		}
	}
	public void deleteResumeByTaskCode(String taskCode) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_RESUME);
		if(taskCode != null && !"".equals(taskCode)){
			sql.append(" WHERE A.TASK_CODE=?");
			int[] types = new int[] {Types.VARCHAR};
			Object[] objs = new Object[] {taskCode};
			executeUpdate(sql.toString(), types, objs);
		}
	}
	public void deleteElectronicByTaskCode(String taskCode) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_ELECTRONIC);
		if(taskCode != null && !"".equals(taskCode)){
			sql.append(" WHERE A.TASK_CODE=?");
			int[] types = new int[] {Types.VARCHAR};
			Object[] objs = new Object[] {taskCode};
			executeUpdate(sql.toString(), types, objs);
		}
	}
	public void deleteDutyBySessionId(String sessionId) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_DUTY);
		if(sessionId != null && !"".equals(sessionId)){
			sql.append(" WHERE D.SESSION_ID=?");
			int[] types = new int[] {Types.VARCHAR};
			Object[] objs = new Object[] {sessionId};
			executeUpdate(sql.toString(), types, objs);
		}
	}
	
	/**
	 * 根据taskcode更新备案人员的备案状态
	 * @param regStatus
	 * @param taskCode
	 */
	public void updateRegStatus(String regStatus, String taskCode) {
		int[] types = new int[] {Types.VARCHAR, Types.VARCHAR};
		Object[] objs = new Object[] {regStatus, taskCode};
		executeUpdate(UPDATE_REG_STATUS, types, objs);
	}
	/**
	 * 通过任职状态删除任职信息
	 * @param regStatus
	 * @param sorgId
	 */
	public void deleteByRegStatus(String sorgId, String regStatus) {
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_DUTY);
		if(sorgId != null && !"".equals(sorgId)){
			sql.append(" WHERE D.SORG_ID=? AND D.REG_STATUS=?");
			int[] types = new int[] {Types.VARCHAR, Types.VARCHAR};
			Object[] objs = new Object[] {sorgId, regStatus};
			executeUpdate(sql.toString(), types, objs);
		}
	}
	
	@SuppressWarnings("unchecked")
	public DataSet queryPeopleByName(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(QURTY_DUTY_BY_NAME);
		String name=(String)pset.getParameter("NAME");
		String sorgId = (String) pset.getParameter("SORG_ID");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		
		if(name != null && !name.equals("")){
			typeList.add(Types.VARCHAR);
			objList.add(name);
		}
		if(sorgId != null && !sorgId.equals("")){
			typeList.add(Types.VARCHAR);
			objList.add(sorgId);
		}
		DataSet ds = new DataSet();
		if(typeList.size()!=0 && objList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int j = 0; j < typeList.size(); j++) {
				types[j]=typeList.get(j);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet ds0 = this.executeDataset(sql.toString(),types,objs,true);
			List<Record> list = ds0.getRecordSet();
			for (int i = 0; i < list.size(); i++) {
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
				somDuty.setPartyLeaderLevel((String) rd.get("PARTY_LEADER_LEVEL"));
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
	
	@SuppressWarnings("unchecked")
	public DataSet queryChangedLegalPeopleByName(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(QURTY_CHANGED_LEGAL_DUTY_BY_NAME);
		String name=(String)pset.getParameter("NAME");
		String sorgId = (String) pset.getParameter("SORG_ID");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		
		if(name != null && !name.equals("")){
			typeList.add(Types.VARCHAR);
			objList.add(name);
		}
		if(sorgId != null && !sorgId.equals("")){
			typeList.add(Types.VARCHAR);
			objList.add(sorgId);
		}
		DataSet ds = new DataSet();
		if(typeList.size()!=0 && objList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int j = 0; j < typeList.size(); j++) {
				types[j]=typeList.get(j);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			DataSet ds0 = this.executeDataset(sql.toString(),types,objs,true);
			List<Record> list = ds0.getRecordSet();
			for (int i = 0; i < list.size(); i++) {
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
				somDuty.setPartyLeaderLevel((String) rd.get("PARTY_LEADER_LEVEL"));
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
