package com.inspur.cams.bpt.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.cms.util.StringUtil;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.base.dao.IBptStateChangeDao;
import com.inspur.cams.bpt.base.data.BptStateChange;


/**
 * @title:BptStateChangeDao
 * @description:
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
 public class BptStateChangeDao extends EntityDao<BptStateChange> implements IBptStateChangeDao{

 	public BptStateChangeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<BptStateChange> getEntityClass() {
		return BptStateChange.class;
	}

	//修改变更表BPT_STATE_CHANGE信息
	public void updateStateChange(BptStateChange bptStateChange){
		StringBuffer sql = new StringBuffer("UPDATE BPT_STATE_CHANGE T SET ");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if (bptStateChange.getChangeStateSuf() != null && !"".equals(bptStateChange.getChangeStateSuf())) {
			sql.append("T.CHANGE_STATE_SUF = ?");
			typeList.add(Types.CHAR);
			argsList.add(bptStateChange.getChangeStateSuf());
		}
		if (bptStateChange.getDeathDate() != null && !"".equals(bptStateChange.getDeathDate())) {
			sql.append(",T.DEATH_DATE = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(bptStateChange.getDeathDate());
		}	
		if (bptStateChange.getAllowanceMonth() != null && !"".equals(bptStateChange.getAllowanceMonth())) {
			sql.append(",T.ALLOWANCE_MONTH = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(bptStateChange.getAllowanceMonth());
		}
		if (bptStateChange.getNote() != null && !"".equals(bptStateChange.getNote())) {
			sql.append(",T.NOTE = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(bptStateChange.getNote());
		}
		if (bptStateChange.getStateChangeId() != null && !"".equals(bptStateChange.getStateChangeId())) {
			sql.append(" WHERE T.STATE_CHANGE_ID = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(bptStateChange.getStateChangeId());
		}
		
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			this.executeUpdate(sql.toString(), types, args);
		}
		
	}
   //修改人员状态
	public void updateClass(BptStateChange bptStateChange){
		//查询获取伤残、在乡复员、参战参试、三属的值
		String peopleSql = "SELECT T.DISABILITY_FLAG,T.DEMOBILIZED_FLAG,T.WAR_FLAG,T.DEPENDANT_FLAG FROM BASEINFO_PEOPLE T WHERE T.PEOPLE_ID = ? ";
		DataSet dSet = this.executeDataset(peopleSql,new int[]{Types.VARCHAR},new Object[]{bptStateChange.getPeopleId()},true);
		String disability_flag = (String) dSet.getRecord(0).get("DISABILITY_FLAG");
		String demobilized_flag = (String) dSet.getRecord(0).get("DEMOBILIZED_FLAG");
		String war_flag = (String) dSet.getRecord(0).get("WAR_FLAG");
		String dependant_flag = (String) dSet.getRecord(0).get("DEPENDANT_FLAG");
		
		StringBuffer sql = new StringBuffer("UPDATE BASEINFO_PEOPLE T SET ");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		//根据查询获取伤残、在乡复员、参战参试、三属的值，判断是否要写入修改后的值
		if (war_flag != null && !"".equals(war_flag)) {
			if ("1".equals(war_flag)) {
				if (bptStateChange.getChangeStateSuf() != null && !"".equals(bptStateChange.getChangeStateSuf())) {
					sql.append("T.WAR_STATE_CODE = ?");
					typeList.add(Types.VARCHAR);
					argsList.add(bptStateChange.getChangeStateSuf());
				}
			}
		}
		if (demobilized_flag != null && !"".equals(demobilized_flag)) {
			if ("1".equals(demobilized_flag)) {
				if (bptStateChange.getChangeStateSuf() != null && !"".equals(bptStateChange.getChangeStateSuf())) {
					sql.append(" T.DEMOBILIZED_STATE_CODE = ?");
					typeList.add(Types.VARCHAR);
					argsList.add(bptStateChange.getChangeStateSuf());
				}
			}
		}
		if (dependant_flag != null && !"".equals(dependant_flag)) {
			if ("1".equals(dependant_flag)) {
				if (bptStateChange.getChangeStateSuf() != null && !"".equals(bptStateChange.getChangeStateSuf())) {
					sql.append(" T.DEPENDANT_STATE_CODE = ?");
					typeList.add(Types.VARCHAR);
					argsList.add(bptStateChange.getChangeStateSuf());
				}
			}
		}
		if (disability_flag != null && !"".equals(disability_flag)) {
			if ("1".equals(disability_flag)) {
				if (bptStateChange.getChangeStateSuf() != null && !"".equals(bptStateChange.getChangeStateSuf())) {
					sql.append(" T.DISABILITY_STATE_CODE = ?");
					typeList.add(Types.VARCHAR);
					argsList.add(bptStateChange.getChangeStateSuf());
				}
			}
		}
		if (bptStateChange.getPeopleId() != null && !"".equals(bptStateChange.getPeopleId())) {
			sql.append(" WHERE T.PEOPLE_ID = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(bptStateChange.getPeopleId());
		}
		if (typeList.size() != 0 && argsList.size() != 0) {
			int [] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			this.executeUpdate(sql.toString(),types,args);
		}
	}
	/**
	 * 获取最新的变更前信息
	 * @return
	 */
	public String queryPreStateChange(String peopleId){
		String changestatepre="";
		StringBuffer sql = new StringBuffer();
		sql.append("select  t.change_state_pre from bpt_state_change t where t.people_id = ? order by t.change_state_date desc");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		if(peopleId!=null&&!"".equals(peopleId)){
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if (typeList.size() != 0 && argsList.size() != 0) {
			int [] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			DataSet ds = this.executeDataset(sql.toString(),types,args,true);
			if(ds.getCount()>0){
				changestatepre = (String)ds.getRecord(0).get("CHANGE_STATE_PRE");
			}
		}
		return changestatepre;
	}
}
