package com.inspur.cams.comm.workflow.taskinfo.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.workflow.taskinfo.dao.ITaskInfoQueryDao;
import com.inspur.cams.comm.workflow.taskinfo.util.QueryConditionUtil;

/**
 * @title:TaskInfoQueryDao
 * @description:
 * @author:	zhaojin
 * @since:2012-05-11
 * @version:1.0
*/
 public class TaskInfoQueryDao extends BaseJdbcDao implements ITaskInfoQueryDao{

 	public TaskInfoQueryDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

   /**
     * 查询待办 
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @param mysetwhere 自定义查询条件 形式如：String@oprationSymbol:value&String@oprationSymbol:value 
	 * @param tableName  业务表名
	 * @param tableKey 	 业务表主键
	 * @param applyShowColum 业务表select的字段 如 TASK_CODE,PROCESS_ID
	 * @param flowShowColum  流程表select的字段 如 TASK_CODE,PROCESS_ID
	 * @return
	 */
   @SuppressWarnings("unchecked")
   public  DataSet queryDaiBan(ParameterSet pset){
	 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
	 String procTypeId=(String)pset.getParameter("processType");
	 String actDefName=(String)pset.getParameter("actDefName");
	 String organId=BspUtil.getEmpOrgan().getOrganId();
	 String mysetwhere=(String)pset.getParameter("mysetwhere");
	 String tableName=(String)pset.getParameter("tableName");
	 String tableKey=(String)pset.getParameter("tableKey");
	 //select出来业务表需要显示的字段，因为业务表和流程表里的字段有可能有重复的，用T.*会报错
	 String applyShowColum=(String)pset.getParameter("applyShowColum");
	 //select出来待办表需要显示的字段，因为业务表和流程表里的字段有可能有重复的，用W.*会报错
	 String flowShowColum=(String)pset.getParameter("flowShowColum");
	 StringBuffer sql = new StringBuffer();
	 sql.append("SELECT ");
	 if(flowShowColum != null){
		 sql.append(queryConditionUtil.parseShowColum(flowShowColum, "W"));
	 } else{
		 sql.append("W.*");
	 }
	 if(applyShowColum != null){
		 sql.append(","+queryConditionUtil.parseShowColum(applyShowColum, "T"));
	 } else{
		 sql.append(",T.*");
	 }
	 sql.append(" FROM  WF_DAI_BAN_TASK W , ");
	 sql.append(tableName);
	 sql.append(" T  WHERE W.PRIMARY_KEY= T.");
	 sql.append(tableKey);
	 sql.append(" AND W.IS_VISIBLE='1'");
	 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME = ?");
	 List typeList = new ArrayList();
	 List argsList = new ArrayList();
	 typeList.add(Types.VARCHAR);
	 argsList.add(organId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(procTypeId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(actDefName);
	 //拆分自定义查询字段
	 if(mysetwhere !=null ){
		 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
	 }
	 sql.append(" ORDER BY W.CREATE_TIME DESC");
	 int[] types = new int[typeList.size()];
	 for (int i = 0; i < typeList.size(); i++) {
		types[i] = (Integer) (typeList.get(i));
	 }
	 Object[] args = argsList.toArray(new Object[argsList.size()]);
	 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	 
   }
   /**
     * 查询已办 
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @param mysetwhere 自定义查询条件 形式如：String@oprationSymbol:value&String@oprationSymbol:value 
	 * @param tableName  业务表名
	 * @param tableKey 	 业务表主键
	 * @param applyShowColum 业务表select的字段 如 TASK_CODE,PROCESS_ID
	 * @param flowShowColum  流程表select的字段 如 TASK_CODE,PROCESS_ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryYiBan(ParameterSet pset) {
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String procTypeId=(String)pset.getParameter("processType");
		 String actDefName=(String)pset.getParameter("actDefName");
		 String organId=BspUtil.getEmpOrgan().getOrganId();
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 String tableName=(String)pset.getParameter("tableName");
		 String tableKey=(String)pset.getParameter("tableKey");
		 //select出来业务表需要显示的字段，因为业务表和流程表里的字段有可能有重复的，用T.*会报错
		 String applyShowColum=(String)pset.getParameter("applyShowColum");
		 //select出来待办表需要显示的字段，因为业务表和流程表里的字段有可能有重复的，用W.*会报错
		 String flowShowColum=(String)pset.getParameter("flowShowColum");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT ");
		 if(flowShowColum != null){
			 sql.append(queryConditionUtil.parseShowColum(flowShowColum, "W"));
		 } else{
			 sql.append("W.*");
		 }
		 if(applyShowColum != null){
			 sql.append(","+queryConditionUtil.parseShowColum(applyShowColum, "T"));
		 } else{
			 sql.append(",T.* ");
		 }
		 sql.append(" FROM  ");
		 sql.append(tableName);
		 sql.append(" T , WF_YI_BAN_TASK W  WHERE T.");
		 sql.append(tableKey);
		 sql.append("=W.PRIMARY_KEY ");
		 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME = ?");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(actDefName);
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
		 }
		 sql.append(" ORDER BY W.END_TIME DESC");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	}
	 /**
	 * 查询结束任务
	 * @param processType 流程类型
	 * @param actDefName 环节名称
	 * @param mysetwhere 自定义查询条件 形式如：String@oprationSymbol:value&String@oprationSymbol:value 
	 * @param tableName  业务表名
	 * @param tableKey 	 业务表主键
	 * @param applyShowColum 业务表select的字段 如 TASK_CODE,PROCESS_ID
	 * @param flowShowColum  流程表select的字段 如 TASK_CODE,PROCESS_ID
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryEnd(ParameterSet pset){
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String procTypeId=(String)pset.getParameter("processType");
		 String organId=BspUtil.getEmpOrgan().getOrganId();
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 String actDefName=(String)pset.getParameter("actDefName");
		 String tableName=(String)pset.getParameter("tableName");
		 String tableKey=(String)pset.getParameter("tableKey");
		 String applyShowColum=(String)pset.getParameter("applyShowColum");
		//select出来待办表需要显示的字段，因为业务表和流程表里的字段有可能有重复的，用W.*会报错
		 String flowShowColum=(String)pset.getParameter("flowShowColum");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT ");
		 if(flowShowColum != null){
			 sql.append(queryConditionUtil.parseShowColum(flowShowColum, "W"));
		 } else{
			 sql.append("W.*");
		 }
		 if(applyShowColum != null){
			 sql.append(","+queryConditionUtil.parseShowColum(applyShowColum, "T"));
		 } else{
			 sql.append(",T.* ");
		 }
		 sql.append(" FROM  ");
		 sql.append(tableName);
		 sql.append(" T , WF_END_TASK W  WHERE T.");
		 sql.append(tableKey);
		 sql.append("=W.PRIMARY_KEY ");
		 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME = ?");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(actDefName);
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
		 }
		 sql.append(" ORDER BY W.END_TIME DESC");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	}

	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
