package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.sorg.base.dao.ISomPeopleDao;
import com.inspur.cams.sorg.base.data.SomPeople;

/**
 * 社会组织人员dao实现类
 * @author Muqi
 * @date 2011年9月20日
 */
public class SomPeopleDao extends EntityDao<SomPeople> implements ISomPeopleDao {
	public static String QUERY_RESTRICT="SELECT P.*,R.* FROM SOM_PEOPLE P,(SELECT DISTINCT RP.* FROM (SELECT P.PEOPLE_ID RESTRICT_PEOPLE_ID, P.ID_CARD RESTRICT_ID_CARD, P.IF_LIMIT FROM SOM_RESTRICT_PEOPLE P, SOM_RESTRICT_PEOPLE_DETAIL D WHERE P.PEOPLE_ID = D.PEOPLE_ID AND P.IF_VALID = '1' AND D.ADD_OPERATION = 'ADD') RP) R WHERE P.ID_CARD = R.RESTRICT_ID_CARD(+) ";

	@Override
	protected Class<SomPeople> getEntityClass() {
		return SomPeople.class;
	}

	/**
	 * 更新照片
	 */
	public String updatePhoto(String photoId, String photoText) {
		if(photoId!=null && !("".equals(photoId.trim())) && photoText!=null && !("".equals(photoText.trim()))){
			//删除原照片
			StringBuffer querySql = new StringBuffer();
			String tableName = "COM_PHOTO_"+photoId.substring(0,6);
			querySql.append("delete from ").append(tableName).append(" where PHOTO_ID=?");
			this.executeUpdate(querySql.toString(), new int[]{Types.VARCHAR}, new Object[]{photoId});
			//保存新照片
			String newPhotoId = PhotoUtil.savePhoto(photoText);
			return newPhotoId;
		}
		return null;
	}
	
	/**
	 * 查询带有受限信息的人员信息
	 */
	public DataSet queryRestrict(ParameterSet pset){
		StringBuffer sql = new StringBuffer();
		sql.append(QUERY_RESTRICT);
		String idCard=(String)pset.getParameter("ID_CARD");
		String peopleId = (String) pset.getParameter("PEOPLE_ID");
		String restrictPeopleId = (String) pset.getParameter("RESTRICT_PEOPLE_ID");
		String ifLimit = (String) pset.getParameter("IF_LIMIT");
		String name = (String) pset.getParameter("NAME");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		if(idCard != null && !idCard.equals("")){
			sql.append(" AND P.ID_CARD=?");
			typeList.add(Types.VARCHAR);
			objList.add(idCard);
		}
		if(name != null && !name.equals("")){
			sql.append(" AND P.NAME=?");
			typeList.add(Types.VARCHAR);
			objList.add(name);
		}
		if(peopleId != null && !peopleId.equals("")){
			sql.append(" AND P.PEOPLE_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(peopleId);
		}
		if(restrictPeopleId != null && !restrictPeopleId.equals("")){
			sql.append(" AND R.RESTRICT_PEOPLE_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(restrictPeopleId);
		}
		if(ifLimit != null && !ifLimit.equals("")){
			sql.append(" AND R.IF_LIMIT=?");
			typeList.add(Types.VARCHAR);
			objList.add(ifLimit);
		}
		sql.append( " ORDER BY R.IF_LIMIT DESC");
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
				SomPeople somPeole = new SomPeople();
				//人员信息
				somPeole.setPeopleId((String) rd.get("PEOPLE_ID"));
				somPeole.setName((String) rd.get("NAME"));
				somPeole.setAliasName((String) rd.get("ALIAS_NAME"));
				somPeole.setSex((String) rd.get("SEX"));
				somPeole.setFolk((String) rd.get("FOLK"));
				somPeole.setBirthday((String) rd.get("BIRTHDAY"));
				somPeole.setNation((String) rd.get("NATION"));
				somPeole.setCardType((String) rd.get("CARD_TYPE"));
				somPeole.setIdCard((String) rd.get("ID_CARD"));
				somPeole.setPolitics((String) rd.get("POLITICS"));
				somPeole.setEducation((String) rd.get("EDUCATION"));
				somPeole.setPopulace((String) rd.get("POPULACE"));
				somPeole.setBirthplace((String) rd.get("BIRTHPLACE"));
				somPeole.setAdds((String) rd.get("ADDS"));
				somPeole.setPostCode((String) rd.get("POST_CODE"));
				somPeole.setPhone((String) rd.get("PHONE"));
				somPeole.setIfPartyLeader((String) rd.get("IF_PARTY_LEADER"));
				somPeole.setIfRetire((String) rd.get("IF_RETIRE"));
				somPeole.setWorkName((String) rd.get("WORK_NAME"));
				somPeole.setWorkPhone((String) rd.get("WORK_PHONE"));
				somPeole.setWorkDuties((String) rd.get("WORK_DUTIES"));
				somPeole.setProfession((String) rd.get("PROFESSION"));
				somPeole.setIfFulltime((String) rd.get("IF_FULLTIME"));
				somPeole.setPeoplePartyType((String) rd.get("PEOPLE_PARTY_TYPE"));
				somPeole.setJoinDate((String) rd.get("JOIN_DATE"));
				somPeole.setRelation((String) rd.get("RELATION"));
				somPeole.setPartyDuties((String) rd.get("PARTY_DUTIES"));
				somPeole.setIfMoblie((String) rd.get("IF_MOBLIE"));
				somPeole.setDevelopDate((String) rd.get("DEVELOP_DATE"));
				somPeole.setActivistsDate((String) rd.get("ACTIVISTS_DATE"));
				somPeole.setApplicationDate((String) rd.get("APPLICATION_DATE"));
				somPeole.setResume((String) rd.get("RESUME"));
				somPeole.setIfLegal((String) rd.get("IF_LEGAL"));
				somPeole.setRelative((String) rd.get("RELATIVE"));
				somPeole.setPhotoId((String) rd.get("PHOTO_ID"));
				somPeole.setNote((String) rd.get("NOTE"));
				somPeole.setCreatePeople((String) rd.get("CREATE_PEOPLE"));
				somPeole.setCreateTime((String) rd.get("CREATE_TIME"));
				somPeole.setPersonUnit((String) rd.get("PERSON_UNIT"));
				somPeole.setPersonUnitPhone((String) rd.get("PERSON_UNIT_PHONE"));
				//受限人员信息
				somPeole.setRestrictPeopleId((String)rd.get("RESTRICT_PEOPLE_ID"));
				somPeole.setIfLimit((String)rd.get("IF_LIMIT"));
				ds.addRecord(somPeole);
			}
		}
		return ds;
	}
	
}
