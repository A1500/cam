package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.sorg.base.dao.ISomAspchiefDao;
import com.inspur.cams.sorg.base.data.SomAspchief;

/**
 * 社会组织拟任负责人dao实现类
 * @author shgtch
 * @date 2011-8-15
 */
public class SomAspchiefDao extends EntityDao<SomAspchief> implements
		ISomAspchiefDao {

	private static String deleteBySorgIdSql = "DELETE FROM SOM_ASPCHIEF WHERE SORG_ID = ?";
	
	private static String deleteByTaskCodeSql = "DELETE FROM SOM_ASPCHIEF WHERE TASK_CODE = ?";
	
	private static String QUERY_ASPCHIE = "SELECT * FROM SOM_ASPCHIEF D WHERE 1=1 ";
	@Override
	public Class<SomAspchief> getEntityClass() {
		return SomAspchief.class;
	}

	/**
	 * 通过社会组织内码删除所有发起人（单位）
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId) {
		int[] types = new int[] { Types.VARCHAR };
		Object[] args = new Object[] { sorgId };
		executeUpdate(deleteBySorgIdSql, types, args);
	}

	public void deleteAllAspchiefByTaskCode(String taskCode) {
		if(taskCode!=null && !"".equals(taskCode)){
			int[] types = new int[] { Types.VARCHAR };
			Object[] args = new Object[] { taskCode };
			executeUpdate(deleteByTaskCodeSql, types, args);
		}	
	}

	public DataSet queryNoPage(ParameterSet pset) {
		StringBuffer sql = new StringBuffer(QUERY_ASPCHIE);
		String sorgId = (String)pset.getParameter("SORG_ID@=");
		String taskCode = (String) pset.getParameter("TASK_CODE");
		String sorgDuties = (String) pset.getParameter("SORG_DUTIES");
		String sorgDuties2 = (String) pset.getParameter("SORG_DUTIES@in");
		
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		
		if(sorgId != null && !sorgId.equals("")){
			sql.append(" AND D.SORG_ID=?");
			typeList.add(Types.VARCHAR);
			objList.add(sorgId);
		}
		if(taskCode != null && !taskCode.equals("")){
			sql.append(" AND D.TASK_CODE=?");
			typeList.add(Types.VARCHAR);
			objList.add(taskCode);
		}
		if(sorgDuties != null && !sorgDuties.equals("")){
			sql.append(" AND D.SORG_DUTIES=?");
			typeList.add(Types.VARCHAR);
			objList.add(sorgDuties);
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
				SomAspchief bean = new SomAspchief();
				bean.setId((String) rd.get("ID"));
				bean.setSorgId((String) rd.get("SORG_ID"));
				bean.setTaskCode((String) rd.get("TASK_CODE"));
				bean.setElectionId((String) rd.get("ELECTION_ID"));
				bean.setName((String) rd.get("NAME"));
				bean.setSex((String) rd.get("SEX"));
				bean.setBirthday((String) rd.get("BIRTHDAY"));
				bean.setIdCard((String) rd.get("ID_CARD"));
				bean.setPolitics((String) rd.get("POLITICS"));
				bean.setWorkDuties((String) rd.get("WORK_DUTIES"));
				bean.setWorkName((String) rd.get("WORK_NAME"));
				bean.setPopulace((String) rd.get("POPULACE"));
				bean.setPhone((String) rd.get("PHONE"));
				bean.setSorgDuties((String) rd.get("SORG_DUTIES"));
				bean.setPromiseCode((String) rd.get("PROMISE_CODE"));
				bean.setPromiseDate((String) rd.get("PROMISE_DATE"));
				bean.setPromiseOrgan((String) rd.get("PROMISE_ORGAN"));
				bean.setMorgArea((String) rd.get("MORG_AREA"));
				bean.setMorgName((String) rd.get("MORG_NAME"));
				bean.setCreatePeople((String) rd.get("CREATE_PEOPLE"));
				bean.setCreateTime((String) rd.get("CREATE_TIME"));
				bean.setOtherDuties((String) rd.get("OTHER_DUTIES"));
				bean.setPenal((String) rd.get("PENAL"));
				bean.setIfRetire((String) rd.get("IF_RETIRE"));
				bean.setIfFulltime((String) rd.get("IF_FULLTIME"));
				bean.setRelative((String) rd.get("RELATIVE"));
				bean.setCitizenship((String) rd.get("CITIZENSHIP"));
				bean.setCardType((String) rd.get("CARD_TYPE"));
				bean.setPostCode((String) rd.get("POST_CODE"));
				bean.setAge((String) rd.get("AGE"));
				bean.setFolk((String) rd.get("FOLK"));
				bean.setIfLegal((String) rd.get("IF_LEGAL"));
				ds.addRecord(bean);
			}
		}
		return ds;
	}

}
