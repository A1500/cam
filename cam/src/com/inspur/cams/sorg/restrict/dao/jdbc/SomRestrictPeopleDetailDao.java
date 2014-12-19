package com.inspur.cams.sorg.restrict.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.sorg.restrict.dao.ISomRestrictPeopleDetailDao;
import com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail;

/**
 * @title:社会组织受限制人员明细表dao
 * @description:
 * @author:
 * @since:2012-03-19
 * @version:1.0
*/
public class SomRestrictPeopleDetailDao extends EntityDao<SomRestrictPeopleDetail> implements ISomRestrictPeopleDetailDao{
		
	public static String SOM_PEOPLE_DETAIL = "SELECT D.ID,D.PEOPLE_ID,D.TASK_CODE,D.IF_LEGAL,D.SOURCE_TYPE,D.SORG_CODE,D.ADD_AREA,D.ADD_PERSON_ID,D.ADD_PERSON_NAME,D.ADD_TIME,D.ADD_ORGAN_ID,D.ADD_ORGAN_NAME,D.ADD_OPERATION,D.NOTE, P.NAME,P.ID_CARD,P.IF_LIMIT,P.IF_VALID FROM SOM_RESTRICT_PEOPLE_DETAIL D, SOM_RESTRICT_PEOPLE P WHERE D.PEOPLE_ID = P.PEOPLE_ID ";
	public static String DELETE_DETAIL = "DELETE FROM SOM_RESTRICT_PEOPLE_DETAIL D WHERE 1=1 ";
	@Override
	protected Class<SomRestrictPeopleDetail> getEntityClass() {
		return SomRestrictPeopleDetail.class;
	}
	
	@SuppressWarnings("unchecked")
	public DataSet queryPeople(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		sql.append(SOM_PEOPLE_DETAIL);
		String idCard=(String)pset.getParameter("ID_CARD");
		String peopleId = (String) pset.getParameter("PEOPLE_ID");
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String ifLimit = (String) pset.getParameter("IF_LIMIT");
		String ifValid = (String) pset.getParameter("IF_VALID");
		String addOperation = (String) pset.getParameter("ADD_OPERATION");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		
		if(taskCode != null && !taskCode.equals("")){
			sql.append(" AND D.TASK_CODE=?");
			typeList.add(Types.VARCHAR);
			objList.add(taskCode);
		}
		if(idCard != null && !idCard.equals("")){
			sql.append(" AND P.ID_CARD=?");
			typeList.add(Types.VARCHAR);
			objList.add(idCard);
		}
		if(peopleId != null && !peopleId.equals("")){
			sql.append(" AND D.PEOPLE_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(peopleId);
		}
		if(ifLimit != null && !ifLimit.equals("")){
			sql.append(" AND P.IF_LIMIT=?");
			typeList.add(Types.VARCHAR);
			objList.add(ifLimit);
		}
		//是否有效
		if(ifValid != null && !ifValid.equals("")){
			sql.append(" AND P.IF_VALID=?");
			typeList.add(Types.VARCHAR);
			objList.add(ifValid);
		}else{
			sql.append(" AND P.IF_VALID=?");
			typeList.add(Types.VARCHAR);
			objList.add("1");			
		}
		//添加操作
		if(addOperation != null && !addOperation.equals("")){
			sql.append(" AND D.ADD_OPERATION=?");
			typeList.add(Types.VARCHAR);
			objList.add(addOperation);
		}else{
			sql.append(" AND D.ADD_OPERATION=?");
			typeList.add(Types.VARCHAR);
			objList.add("ADD");			
		}
		
		sql.append( " ORDER BY D.IF_LEGAL DESC");
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
				SomRestrictPeopleDetail somRestrictPeopleDetail = new SomRestrictPeopleDetail();
				//人员信息
				somRestrictPeopleDetail.setPeopleId((String) rd.get("PEOPLE_ID"));
				somRestrictPeopleDetail.setName((String) rd.get("NAME"));
				somRestrictPeopleDetail.setIdCard((String) rd.get("ID_CARD"));
				somRestrictPeopleDetail.setIfLimit((String) rd.get("IF_LIMIT"));
				somRestrictPeopleDetail.setIfValid((String) rd.get("IF_VALID"));
				//任职信息
				somRestrictPeopleDetail.setId((String) rd.get("ID"));
				somRestrictPeopleDetail.setTaskCode((String) rd.get("TASK_CODE"));
				somRestrictPeopleDetail.setIfLegal((String) rd.get("IF_LEGAL"));
				somRestrictPeopleDetail.setSourceType((String) rd.get("SOURCE_TYPE"));
				somRestrictPeopleDetail.setSorgCode((String) rd.get("SORG_CODE"));
				somRestrictPeopleDetail.setAddArea((String) rd.get("ADD_AREA"));
				somRestrictPeopleDetail.setAddPersonId((String) rd.get("ADD_PERSON_ID"));
				somRestrictPeopleDetail.setAddPersonName((String) rd.get("ADD_PERSON_NAME"));
				somRestrictPeopleDetail.setAddTime((String) rd.get("ADD_TIME"));
				somRestrictPeopleDetail.setAddOrganId((String) rd.get("ADD_ORGAN_ID"));
				somRestrictPeopleDetail.setAddOrganName((String) rd.get("ADD_ORGAN_NAME"));
				somRestrictPeopleDetail.setAddOperation((String) rd.get("ADD_OPERATION"));
				somRestrictPeopleDetail.setNote((String) rd.get("NOTE"));
				ds.addRecord(somRestrictPeopleDetail);
			}
		}
		return ds;
	}
	/**
	 * 根据taskCode删除受限人员明细
	 */
	public void deleteByTaskCode(ParameterSet pset){
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String peopleId = (String) pset.getParameter("PEOPLE_ID");
		StringBuffer sql = new StringBuffer();
		sql.append(DELETE_DETAIL);
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		if(taskCode != null && !"".equals(taskCode)){
			sql.append(" AND D.TASK_CODE=?");
			typeList.add(Types.VARCHAR);
			objList.add(taskCode);
		}
		if(peopleId != null && !peopleId.equals("")){
			sql.append(" AND D.PEOPLE_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(peopleId);
		}
		if(typeList.size()!=0 && objList.size()!=0){
			int[] types = new int[typeList.size()];
			for (int j = 0; j < typeList.size(); j++) {
				types[j]=typeList.get(j);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			executeUpdate(sql.toString(),types,objs);
		}			
	}
}
