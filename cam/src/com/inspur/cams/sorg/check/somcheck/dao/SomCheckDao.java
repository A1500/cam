package com.inspur.cams.sorg.check.somcheck.dao;

import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.check.somcheck.data.SomCheck;
import com.inspur.cams.sorg.check.somcheckflow.dao.SomCheckFlowDao;
import com.inspur.cams.sorg.check.somcheckflow.data.SomCheckFlow;
import com.inspur.cams.sorg.check.util.CheckProperties;
import com.inspur.cams.sorg.jxcheck.util.JxCheckProperties;

/**
 * @title:SomCheckDao
 * @description:
 * @author:
 * @since:2011-12-21
 * @version:1.0
*/
 public class SomCheckDao extends EntityDao<SomCheck> implements ISomCheckDao{
	 private SomCheckFlowDao somCheckFlowDao = (SomCheckFlowDao) DaoFactory
		.getDao("com.inspur.cams.sorg.check.somcheckflow.dao.SomCheckFlowDao");
 	public SomCheckDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomCheck.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomCheck");
	}
   
   public void updateStatusRecevie(String taskCodeStr,String status,String correctNotReason) {
	   //接收时还没有创建som_check_flow表中数据，此时更新接收时间更新到som_check表
	    String receiveTime = DateUtil.getTime();
	    String receivePerson = BspUtil.getEmpOrgan().getOrganName();
	   	StringBuffer sql = new StringBuffer();
	   	sql.append("UPDATE SOM_CHECK SET STATUS=?,CORRECT_NOT_REASON=?,RECEIVE_TIME=?,RECEIVE_PERSON=? WHERE ");
	   	sql.append(" TASK_CODE in ('").append(taskCodeStr.replaceAll(",", "','")).append("') ");
	    int[] types = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		Object[] objs = new Object[] {status,correctNotReason,receiveTime,receivePerson};
		executeUpdate(sql.toString(), types, objs);
	}
   
   public void updateStatus(String taskCode,String status,String correctNotReason) {
	    int[] types = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		Object[] objs = new Object[] {status,correctNotReason,taskCode};
		executeUpdate("UPDATE SOM_CHECK SET STATUS=?,CORRECT_NOT_REASON=? WHERE TASK_CODE=?", types, objs);
	}
   /**
	 * 查询年检数据是否全部填写,以控制上报
	 * @param taskCode 业务主键
	 * @param sorgType 社会组织类型
	 * @return flag
	 */
	public String queryForReport(String taskCode,String sorgType) {
		StringBuffer flag = new StringBuffer();
		flag.append("第");
		DataSet ds = new DataSet();
		boolean b=false;
		for(int i=1;i<30;i++){
			String properties=CheckProperties.getString(sorgType+i);
			if(properties != null){
				StringBuffer sql = new StringBuffer("select count(*) as num from ");
				sql.append(properties);
				sql.append(" and task_code=?");
				int[] types = new int[] { Types.VARCHAR };
				Object[] args = new Object[] { taskCode };
				ds = executeDataset(sql.toString(), types, args, true);
				if("0".equals(ds.getRecord(0).get("NUM").toString())){
					flag.append(i);
					flag.append(" ");
					b=true;
				}
			}
		}
		flag.append("页数据未进行填写！");
		if(b){
			return flag.toString();
		}else{
			return "true";
		}
		
	}
	
	public DataSet queryNoCheck(ParameterSet pset){
		String areaCode = (String) pset.getParameter("areaCode");
		String status = (String) pset.getParameter("status");
		String userName = (String) pset.getParameter("userName");
		String sorgType = (String) pset.getParameter("sorgType");
		StringBuffer sql = new StringBuffer("SELECT CN_NAME,STATUS,STATUS_DESC,SORG_TYPE,SORG_CODE,MORG_AREA FROM SOMCHECKSTATUSVIEW  WHERE  MORG_AREA LIKE ?");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		DataSet ds = new DataSet();
		typeList.add(Types.VARCHAR);
		objsList.add(areaCode);
		if(userName!=null && !("".endsWith(userName))){
			sql.append(" and CN_NAME = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(userName);
		}
		if(sorgType!=null && !("".endsWith(sorgType))){
			sql.append(" and SORG_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgType);
		}
		if(status!=null && !("".endsWith(status))){
			if("3".equals(status)){
				sql.append(" and STATUS >2");
			}else{
				sql.append(" and STATUS = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(status);
			}
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i]=typeList.get(i);
		}
		Object[] objs = objsList.toArray(new Object[objsList.size()]);
		ds = this.executeDataset(sql.toString(), types, objs ,pset.getPageStart(),pset.getPageLimit(),true);
		return ds;
	}
	
	public DataSet queryNoCheckPenaltied(ParameterSet pset){
		String areaCode = (String) pset.getParameter("areaCode");
		String status = (String) pset.getParameter("status");
		String userName = (String) pset.getParameter("userName");
		String sorgType = (String) pset.getParameter("sorgType");
		StringBuffer sql = new StringBuffer("SELECT CN_NAME,STATUS,STATUS_DESC,SORG_TYPE,SORG_CODE,MORG_AREA FROM SOMCHECKSTATUSYIBANVIEW  WHERE  MORG_AREA LIKE ?");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		DataSet ds = new DataSet();
		typeList.add(Types.VARCHAR);
		objsList.add(areaCode);
		if(userName!=null && !("".endsWith(userName))){
			sql.append(" and CN_NAME = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(userName);
		}
		if(sorgType!=null && !("".endsWith(sorgType))){
			sql.append(" and SORG_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgType);
		}
		if(status!=null && !("".endsWith(status))){
			if("3".equals(status)){
				sql.append(" and STATUS >2");
			}else{
				sql.append(" and STATUS = ?");
				typeList.add(Types.VARCHAR);
				objsList.add(status);
			}
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i]=typeList.get(i);
		}
		Object[] objs = objsList.toArray(new Object[objsList.size()]);
		ds = this.executeDataset(sql.toString(), types, objs ,pset.getPageStart(),pset.getPageLimit(),true);
		return ds;
	}
//	public DataSet queryNoCheck(ParameterSet pset){
//		String areaCode = (String) pset.getParameter("areaCode");
//		String checkYear = (String) pset.getParameter("checkYear");
//		String userName = (String) pset.getParameter("userName");
//		String sorgType = (String) pset.getParameter("sorgType");
//		StringBuffer sql = new StringBuffer("select USER_ID,USER_NAME,AREA_CODE,substr(ORGAN_TYPE,0,1) as ORGAN_TYPE from COM_EXT_USER where  AREA_CODE like ? and USER_ID not in (select FILL_PEOPLE_ID from SOM_CHECK where FILL_PEOPLE_AREA like ? and CHECK_YEAR = ?)");
//		List<Integer> typeList = new ArrayList<Integer>();
//		List<Object> objsList = new ArrayList<Object>();
//		DataSet ds = new DataSet();
//		if(areaCode!=null && !("".endsWith(areaCode))  && checkYear!=null && !("".endsWith(checkYear))){
//			typeList.add(Types.VARCHAR);
//			objsList.add(areaCode);
//			typeList.add(Types.VARCHAR);
//			objsList.add(areaCode);
//			typeList.add(Types.VARCHAR);
//			objsList.add(checkYear);
//			if(userName!=null && !("".endsWith(userName))){
//				sql.append(" and USER_NAME = ?");
//				typeList.add(Types.VARCHAR);
//				objsList.add(userName);
//			}
//			if(sorgType!=null && !("".endsWith(sorgType))){
//				String organType = "";
//				if(sorgType.endsWith("S")){
//					organType = "ST";
//				}
//				if(sorgType.endsWith("M")){
//					organType = "MF";
//				}
//				if(sorgType.endsWith("J")){
//					organType = "JJ";
//				}
//				sql.append(" and ORGAN_TYPE = ?");
//				typeList.add(Types.VARCHAR);
//				objsList.add(organType);
//			}
//			int[] types = new int[typeList.size()];
//			for (int i = 0; i < typeList.size(); i++) {
//				types[i]=typeList.get(i);
//			}
//			Object[] objs = objsList.toArray(new Object[objsList.size()]);
//			ds = this.executeDataset(sql.toString(), types, objs ,pset.getPageStart(),pset.getPageLimit(),true);
//		}
//		return ds;
//	}
	public void updateRecivieDate(String taskCodeStr){
		StringBuffer sql = new StringBuffer();
	   	sql.append("UPDATE SOM_CHECK_FLOW SET  RECEIVE_TIME=?,RECEIVE_PEOPLE_NAME=? WHERE ");
	   	sql.append(" TASK_CODE in ('").append(taskCodeStr.replaceAll(",", "','")).append("') ");
	    int[] types = new int[] {Types.VARCHAR,Types.VARCHAR};
		Object[] objs = new Object[] {DateUtil.getTime(),BspUtil.getCorpOrgan().getOrganName()};
		executeUpdate(sql.toString(), types, objs);
	}
	public void updateDateAndName(String taskCode,String step){
		String sql="";
		if("correct".equals(step)){
			ParameterSet pset=new ParameterSet();
			pset.setParameter("TASK_CODE@=", taskCode);
			DataSet ds=somCheckFlowDao.query(pset);
			if(ds.getCount()==0){
				SomCheckFlow somCheckFlowBean=new SomCheckFlow();
				somCheckFlowBean.setId(IdHelp.getUUID32());
				somCheckFlowBean.setCorrectPeopleName(BspUtil.getCorpOrgan().getOrganName());
				somCheckFlowBean.setCorrectTime(DateUtil.getTime());
				somCheckFlowBean.setTaskCode(taskCode);
				somCheckFlowDao.insert(somCheckFlowBean);
			}else{
				sql=" UPDATE SOM_CHECK_FLOW SET  CORRECT_TIME=?,CORRECT_PEOPLE_NAME=? WHERE TASK_CODE=? ";
				int[] types = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
				Object[] objs = new Object[] {DateUtil.getTime(),BspUtil.getCorpOrgan().getOrganName(),taskCode};
				executeUpdate(sql, types, objs);
			}
	   	}
	}
	public DataSet queryFlowList(ParameterSet pset){
		String fillPeopleArea = (String) pset.getParameter("fillPeopleArea");
		String sorgType = (String) pset.getParameter("sorgType");
		String status = (String) pset.getParameter("status");
		String cnName = (String) pset.getParameter("cnName");
		String sorgCode = (String) pset.getParameter("sorgCode");
		StringBuffer sql = new StringBuffer(" SELECT T.TASK_CODE,T.CN_NAME,T.BATCH_YEAR,T.SORG_CODE,T.STATUS,T.CHECK_RESULT,F.RECEIVE_TIME,F.CORRECT_TIME,F.ACCEPT_DATE,F.CHECK_DATE,F.AUDIT_DATE FROM SOM_CHECK T,SOM_CHECK_FLOW F WHERE T.TASK_CODE=F.TASK_CODE(+) ");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objsList = new ArrayList<Object>();
		DataSet ds = new DataSet();
		if(fillPeopleArea!=null && !("".endsWith(fillPeopleArea))){
			sql.append(" and T.FILL_PEOPLE_AREA LIKE ?");
			typeList.add(Types.VARCHAR);
			objsList.add(fillPeopleArea);
		}
		if(sorgType!=null && !("".endsWith(sorgType))){
			sql.append(" and T.SORG_TYPE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgType);
		}
		if(status!=null && !("".endsWith(status))){
			sql.append(" and T.STATUS = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(status);
		}
		if(cnName!=null && !("".endsWith(cnName))){
			sql.append(" and T.CN_NAME = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(cnName);
		}
		if(sorgCode!=null && !("".endsWith(sorgCode))){
			sql.append(" and T.SORG_CODE = ?");
			typeList.add(Types.VARCHAR);
			objsList.add(sorgCode);
		}
		sql.append(" order by f.AUDIT_DATE,F.CHECK_DATE,F.ACCEPT_DATE,F.CORRECT_TIME,F.RECEIVE_TIME ");
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i]=typeList.get(i);
		}
		Object[] objs = objsList.toArray(new Object[objsList.size()]);
		ds = this.executeDataset(sql.toString(), types, objs ,pset.getPageStart(),pset.getPageLimit(),true);
		return ds;
	}
}
