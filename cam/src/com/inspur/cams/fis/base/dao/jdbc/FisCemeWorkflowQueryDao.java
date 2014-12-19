package com.inspur.cams.fis.base.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.workflow.taskinfo.util.QueryConditionUtil;
import com.inspur.cams.fis.base.dao.IFisCemeWorkflowQueryDao;

/**
 * @title:TaskInfoQueryDao
 * @description:
 * @author:	zhaojin
 * @since:2012-05-11
 * @version:1.0
*/
 public class FisCemeWorkflowQueryDao extends BaseJdbcDao implements IFisCemeWorkflowQueryDao{

 	public FisCemeWorkflowQueryDao() throws Exception {
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
	 StringBuffer sql = new StringBuffer();
	 sql.append("SELECT ");
	 sql.append("W.*");
	 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
	 sql.append(" FROM  WF_DAI_BAN_TASK W , FIS_CEME_APPLY_INFO");
	 sql.append(" T , FIS_CEME_INFO A  WHERE W.PRIMARY_KEY= T.");
	 sql.append("CEME_APPLY_ID");
	 sql.append(" AND W.IS_VISIBLE='1'");
	 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
	 sql.append(" AND A.RECORD_ID = T.RECORD_ID");
	 List typeList = new ArrayList();
	 List argsList = new ArrayList();
	 typeList.add(Types.VARCHAR);
	 argsList.add(organId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(procTypeId);
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
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT W.*");
		 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
		 sql.append(" FROM  FIS_CEME_APPLY_INFO T ,");
		 sql.append("WF_YI_BAN_TASK W ,FIS_CEME_INFO A WHERE T.CEME_APPLY_ID");
		 sql.append("=W.PRIMARY_KEY ");
		 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
		 sql.append(" AND A.RECORD_ID = T.RECORD_ID");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
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
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT W.*");
		 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
		 sql.append(" FROM  FIS_CEME_APPLY_INFO T ,");
		 sql.append(" WF_END_TASK W ,FIS_CEME_INFO A WHERE T. CEME_APPLY_ID");
		 sql.append("=W.PRIMARY_KEY ");
		 sql.append(" AND W.ID IN (SELECT MIN (P.ID) FROM WF_END_TASK P WHERE P.PRIMARY_KEY=W.PRIMARY_KEY AND P.ORGAN_ID=W.ORGAN_ID)");
		 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
		 sql.append(" AND A.RECORD_ID = T.RECORD_ID");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
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


	public DataSet queryWorkflow(ParameterSet pset) {
		 String primaryKey=(String)pset.getParameter("primaryKey");
		 String actDefName=(String)pset.getParameter("actDefName");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT W.* FROM");
		 if(actDefName.equals("审批结束")){
			sql.append(" WF_END_TASK W  WHERE");
			sql.append(" W.PRIMARY_KEY = ?");
			 typeList.add(Types.VARCHAR);
			 argsList.add(primaryKey);
		    sql.append(" ORDER BY W.ACT_DEF_ID DESC");
		 }else{
			sql.append(" WF_DAI_BAN_TASK W WHERE");
			sql.append(" W.PRIMARY_KEY = ? ");
		    typeList.add(Types.VARCHAR);
		    argsList.add(primaryKey);
		 }
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	}

	@Override
	protected void initDao() {
		// TODO 自动生成的方法存根
		
	}
	@SuppressWarnings("unchecked")
	public  DataSet queryDaiBanNJ(ParameterSet pset){
		String procTypeId=(String)pset.getParameter("processType");
		String organId=BspUtil.getEmpOrgan().getOrganId();
		String actDefName=(String)pset.getParameter("actDefName");
		String name=(String)pset.getParameter("queryCemeName");
		String queryTime=(String)pset.getParameter("queryTime");
		String checkResult=(String)pset.getParameter("checkResult");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT W.*,T.CHECK_YEAR,T.CUR_ORGAN,T.FILL_ORGAN_NAME,T.REC_TIME,T.COM_TIME,T.CHECK_RESULT");
		sql.append(",T.APPLY_STATE,T.CHECK_RESULT,T.RECORD_ID,F.NAME FROM WF_DAI_BAN_TASK W , FIS_CEME_APPLY_INFO T");
		sql.append(",FIS_CEME_INFO F WHERE W.PRIMARY_KEY= T.CEME_APPLY_ID AND T.RECORD_ID=F.RECORD_ID ");
		sql.append(" AND W.ACT_DEF_NAME IN (" + actDefName + ")");
		//sql.append("AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ('乡镇申请受理' , '补齐补正') ORDER BY W.CREATE_TIME DESC");	
		
		if (StringUtils.isNotEmpty(organId)) {
			sql.append(" AND  W.ORGAN_ID =?");
			objList.add(organId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(procTypeId)) {
			sql.append(" AND  W.PROCESS_TYPE =?");
			objList.add(procTypeId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" AND F.NAME LIKE ?  ");
			objList.add(name);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(checkResult)) {
			sql.append(" AND T.CHECK_RESULT=?  ");
			objList.add(checkResult);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(queryTime)) {
			sql.append(" AND T.CHECK_YEAR=?  ");
			objList.add(queryTime);
			typeList.add(Types.VARCHAR);
		}
		sql.append(" ORDER BY W.CREATE_TIME DESC");
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
		}
		return ds;
	}
	@SuppressWarnings("unchecked")
	public  DataSet queryYiBanNJ(ParameterSet pset){
		String procTypeId=(String)pset.getParameter("processType");
		String organId=BspUtil.getEmpOrgan().getOrganId();
		String actDefName=(String)pset.getParameter("actDefName");
		String name=(String)pset.getParameter("queryCemeName");
		String queryTime=(String)pset.getParameter("queryTime");
		String checkResult=(String)pset.getParameter("checkResult");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT W.*,T.CHECK_YEAR,T.CHECK_RESULT,T.APPLY_STATE,T.CUR_ACTIVITY,T.RECORD_ID,T.CUR_ORGAN,T.FILL_ORGAN_NAME,T.REC_TIME,T.COM_TIME,F.NAME FROM WF_YI_BAN_TASK W , FIS_CEME_APPLY_INFO T");
		sql.append(",FIS_CEME_INFO F WHERE W.PRIMARY_KEY= T.CEME_APPLY_ID AND T.RECORD_ID=F.RECORD_ID ");
		sql.append(" AND W.ACT_DEF_NAME IN (" + actDefName + ")");
		if (StringUtils.isNotEmpty(organId)) {
			sql.append(" AND  W.ORGAN_ID =?");
			objList.add(organId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(procTypeId)) {
			sql.append(" AND  W.PROCESS_TYPE =?");
			objList.add(procTypeId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" AND F.NAME LIKE ?  ");
			objList.add(name);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(checkResult)) {
			sql.append(" AND T.CHECK_RESULT=?  ");
			objList.add(checkResult);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(queryTime)) {
			sql.append(" AND T.CHECK_YEAR=?  ");
			objList.add(queryTime);
			typeList.add(Types.VARCHAR);
		}
		sql.append(" ORDER BY W.CREATE_TIME DESC");
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
		}
		return ds;
	}
	@SuppressWarnings("unchecked")
	public  DataSet queryEndNJ(ParameterSet pset){
		String procTypeId=(String)pset.getParameter("processType");
		String organId=BspUtil.getEmpOrgan().getOrganId();
		String actDefName=(String)pset.getParameter("actDefName");
		String name=(String)pset.getParameter("queryCemeName");
		String queryTime=(String)pset.getParameter("queryTime");
		String checkResult=(String)pset.getParameter("checkResult");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT W.*,T.CHECK_YEAR,T.CHECK_RESULT,T.RECORD_ID,T.CEME_APPLY_ID,F.NAME FROM WF_END_TASK W , FIS_CEME_APPLY_INFO T");
		sql.append(",FIS_CEME_INFO F WHERE W.PRIMARY_KEY= T.CEME_APPLY_ID AND T.RECORD_ID=F.RECORD_ID ");
		sql.append(" AND W.ID IN (SELECT MIN (P.ID) FROM WF_END_TASK P WHERE P.PRIMARY_KEY=W.PRIMARY_KEY AND P.ORGAN_ID=W.ORGAN_ID)");
		sql.append(" AND W.ACT_DEF_NAME IN (" + actDefName + ")");
		if (StringUtils.isNotEmpty(organId)) {
			sql.append(" AND  W.ORGAN_ID =?");
			objList.add(organId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(procTypeId)) {
			sql.append(" AND  W.PROCESS_TYPE =?");
			objList.add(procTypeId);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" AND F.NAME LIKE ?  ");
			objList.add(name);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(checkResult)) {
			sql.append(" AND T.CHECK_RESULT=?  ");
			objList.add(checkResult);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(queryTime)) {
			sql.append(" AND T.CHECK_YEAR=?  ");
			objList.add(queryTime);
			typeList.add(Types.VARCHAR);
		}
		sql.append(" ORDER BY W.CREATE_TIME DESC");
		DataSet ds = new DataSet();
		if (typeList.size() > 0 && objList.size() > 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < types.length; i++) {
				types[i] = typeList.get(i);
			}
			Object[] objs = objList.toArray(new Object[objList.size()]);
			ds = this.executeDataset(sql.toString(), types, objs, true);
		}
		return ds;
	}
	public DataSet queryCreateFlow(ParameterSet pset){
		 String primaryKey=(String)pset.getParameter("primaryKey");
		 String actDefName=(String)pset.getParameter("actDefName");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT W.* FROM");
		 if(actDefName.equals("结束")){
			sql.append(" WF_END_TASK W  WHERE");
			sql.append(" W.PRIMARY_KEY = ?");
			 typeList.add(Types.VARCHAR);
			 argsList.add(primaryKey);
		    sql.append(" ORDER BY W.ACT_DEF_ID DESC");
		 }else{
			sql.append(" WF_DAI_BAN_TASK W WHERE");
			sql.append(" W.PRIMARY_KEY = ? ");
		    typeList.add(Types.VARCHAR);
		    argsList.add(primaryKey);
		 }
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		
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
   public  DataSet queryDaiBanEx(ParameterSet pset){
	 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
	 String procTypeId=(String)pset.getParameter("processType");
	 String actDefName=(String)pset.getParameter("actDefName");
	 String organId=BspUtil.getEmpOrgan().getOrganId();
	 String mysetwhere=(String)pset.getParameter("mysetwhere");
	 StringBuffer sql = new StringBuffer();
	 sql.append("SELECT ");
	 sql.append("W.*");
	 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
	 sql.append(" FROM  WF_DAI_BAN_TASK W ,FIS_CEME_EXPEND_INFO E, FIS_CEME_APPLY_INFO");
	 sql.append(" T , FIS_CEME_INFO A  WHERE W.PRIMARY_KEY= T.");
	 sql.append("CEME_APPLY_ID");
	 sql.append(" AND W.IS_VISIBLE='1'");
	 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
	 sql.append(" AND E.RECORD_ID = T.RECORD_ID AND A.RECORD_ID = E.CEME_ID");
	 List typeList = new ArrayList();
	 List argsList = new ArrayList();
	 typeList.add(Types.VARCHAR);
	 argsList.add(organId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(procTypeId);
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
	public DataSet queryYiBanEx(ParameterSet pset) {
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String procTypeId=(String)pset.getParameter("processType");
		 String actDefName=(String)pset.getParameter("actDefName");
		 String organId=BspUtil.getEmpOrgan().getOrganId();
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT W.*");
		 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
		 sql.append(" FROM  FIS_CEME_APPLY_INFO T ,");
		 sql.append("WF_YI_BAN_TASK W ,FIS_CEME_INFO A, FIS_CEME_EXPEND_INFO E WHERE T.CEME_APPLY_ID");
		 sql.append("=W.PRIMARY_KEY ");
		 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
		 sql.append(" AND E.RECORD_ID = T.RECORD_ID AND A.RECORD_ID = E.CEME_ID");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
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
	public DataSet queryEndEx(ParameterSet pset){
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String procTypeId=(String)pset.getParameter("processType");
		 String organId=BspUtil.getEmpOrgan().getOrganId();
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 String actDefName=(String)pset.getParameter("actDefName");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT W.*");
		 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
		 sql.append(" FROM  FIS_CEME_APPLY_INFO T ,");
		 sql.append("WF_END_TASK W ,FIS_CEME_INFO A, FIS_CEME_EXPEND_INFO E WHERE T.CEME_APPLY_ID");
		 sql.append("=W.PRIMARY_KEY ");
		 sql.append(" AND W.ID IN (SELECT MIN (P.ID) FROM WF_END_TASK P WHERE P.PRIMARY_KEY=W.PRIMARY_KEY AND P.ORGAN_ID=W.ORGAN_ID)");
		 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
		 sql.append(" AND E.RECORD_ID = T.RECORD_ID AND A.RECORD_ID = E.CEME_ID");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
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
   public  DataSet queryDaiBanYS(ParameterSet pset){
	 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
	 String procTypeId=(String)pset.getParameter("processType");
	 String actDefName=(String)pset.getParameter("actDefName");
	 String organId=BspUtil.getEmpOrgan().getOrganId();
	 String mysetwhere=(String)pset.getParameter("mysetwhere");
	 String mysetwhere1=(String)pset.getParameter("mysetwhere1");
	 StringBuffer sql = new StringBuffer();
	 sql.append("SELECT ");
	 sql.append("W.*");
	 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
	 sql.append(" FROM  WF_DAI_BAN_TASK W ,FIS_CEME_EXPEND_INFO E, FIS_CEME_APPLY_INFO");
	 sql.append(" T , FIS_CEME_INFO A  WHERE W.PRIMARY_KEY= T.CEME_APPLY_ID");
	 sql.append(" AND W.IS_VISIBLE='1'");
	 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
	 sql.append(" AND E.RECORD_ID = T.RECORD_ID AND A.RECORD_ID = E.CEME_ID");
	 List typeList = new ArrayList();
	 List argsList = new ArrayList();
	 typeList.add(Types.VARCHAR);
	 argsList.add(organId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(procTypeId);
	 if(mysetwhere !=null ){
		 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
	 }
	 sql.append(" UNION SELECT ");
	 sql.append("WF.*");
	 sql.append(", TA.CEME_APPLY_ID, TA.APPLY_STATE, TA.RECORD_ID, TA.CUR_ACTIVITY, TA.CUR_ORGAN, TA.REC_TIME, TA.COM_TIME, TA.FILL_ORGAN_NAME, TA.IS_REPORT,TA.FIRST_TIME,AA.NAME,TA.ZERO_TIME");
	 sql.append(" FROM  WF_DAI_BAN_TASK WF , FIS_CEME_APPLY_INFO TA");
	 sql.append(",FIS_CEME_INFO AA  WHERE WF.PRIMARY_KEY= TA.CEME_APPLY_ID");
	 sql.append(" AND WF.IS_VISIBLE='1'");
	 sql.append(" AND  WF.ORGAN_ID =? AND WF.PROCESS_TYPE = ? AND WF.ACT_DEF_NAME IN ("+actDefName+")");
	 sql.append(" AND AA.RECORD_ID = TA.RECORD_ID");
	 
	 typeList.add(Types.VARCHAR);
	 argsList.add(organId);
	 typeList.add(Types.VARCHAR);
	 argsList.add(procTypeId);
	 //拆分自定义查询字段
	 if(mysetwhere1 !=null ){
		 queryConditionUtil.buildAllConditionSql(mysetwhere1,typeList,argsList,sql);
	 }
//	 sql.append(" ORDER BY W.CREATE_TIME DESC");
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
	public DataSet queryYiBanYS(ParameterSet pset) {
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String procTypeId=(String)pset.getParameter("processType");
		 String actDefName=(String)pset.getParameter("actDefName");
		 String organId=BspUtil.getEmpOrgan().getOrganId();
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 String mysetwhere1=(String)pset.getParameter("mysetwhere1");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT W.*");
		 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
		 sql.append(" FROM  FIS_CEME_APPLY_INFO T ,");
		 sql.append("WF_YI_BAN_TASK W ,FIS_CEME_INFO A, FIS_CEME_EXPEND_INFO E WHERE T.CEME_APPLY_ID");
		 sql.append("=W.PRIMARY_KEY ");
		 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
		 sql.append(" AND E.RECORD_ID = T.RECORD_ID AND A.RECORD_ID = E.CEME_ID");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
		 }
		 sql.append(" UNION ");
		 sql.append("SELECT WF.*");
		 sql.append(", TA.CEME_APPLY_ID, TA.APPLY_STATE, TA.RECORD_ID, TA.CUR_ACTIVITY, TA.CUR_ORGAN, TA.REC_TIME, TA.COM_TIME, TA.FILL_ORGAN_NAME, TA.IS_REPORT,TA.FIRST_TIME,AA.NAME,TA.ZERO_TIME");
		 sql.append(" FROM  FIS_CEME_APPLY_INFO TA ,");
		 sql.append("WF_YI_BAN_TASK WF ,FIS_CEME_INFO AA WHERE TA.CEME_APPLY_ID");
		 sql.append("=WF.PRIMARY_KEY ");
		 sql.append(" AND  WF.ORGAN_ID =? AND WF.PROCESS_TYPE = ? AND WF.ACT_DEF_NAME IN ("+actDefName+")");
		 sql.append(" AND AA.RECORD_ID = TA.RECORD_ID");
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
		 //拆分自定义查询字段
		 if(mysetwhere1 !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere1,typeList,argsList,sql);
		 }
//		 sql.append(" ORDER BY TA.END_TIME DESC");
		 
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
	public DataSet queryEndYS(ParameterSet pset){
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String procTypeId=(String)pset.getParameter("processType");
		 String organId=BspUtil.getEmpOrgan().getOrganId();
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 String mysetwhere1=(String)pset.getParameter("mysetwhere1");
		 String actDefName=(String)pset.getParameter("actDefName");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT W.*");
		 sql.append(", T.CEME_APPLY_ID, T.APPLY_STATE, T.RECORD_ID, T.CUR_ACTIVITY, T.CUR_ORGAN, T.REC_TIME, T.COM_TIME, T.FILL_ORGAN_NAME, T.IS_REPORT,T.FIRST_TIME,A.NAME,T.ZERO_TIME");
		 sql.append(" FROM  FIS_CEME_APPLY_INFO T ,");
		 sql.append("WF_END_TASK W ,FIS_CEME_INFO A, FIS_CEME_EXPEND_INFO E WHERE T.CEME_APPLY_ID");
		 sql.append("=W.PRIMARY_KEY ");
		 sql.append(" AND W.ID IN (SELECT MIN (P.ID) FROM WF_END_TASK P WHERE P.PRIMARY_KEY=W.PRIMARY_KEY AND P.ORGAN_ID=W.ORGAN_ID)");
		 sql.append(" AND  W.ORGAN_ID =? AND W.PROCESS_TYPE = ? AND W.ACT_DEF_NAME IN ("+actDefName+")");
		 sql.append(" AND E.RECORD_ID = T.RECORD_ID AND A.RECORD_ID = E.CEME_ID");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
		 }
		 sql.append(" UNION ");
		 sql.append("SELECT WF.*");
		 sql.append(", TA.CEME_APPLY_ID, TA.APPLY_STATE, TA.RECORD_ID, TA.CUR_ACTIVITY, TA.CUR_ORGAN, TA.REC_TIME, TA.COM_TIME, TA.FILL_ORGAN_NAME, TA.IS_REPORT,TA.FIRST_TIME,AA.NAME,TA.ZERO_TIME");
		 sql.append(" FROM  FIS_CEME_APPLY_INFO TA ,");
		 sql.append(" WF_END_TASK WF ,FIS_CEME_INFO AA WHERE TA. CEME_APPLY_ID");
		 sql.append("=WF.PRIMARY_KEY ");
		 sql.append(" AND WF.ID IN (SELECT MIN (P.ID) FROM WF_END_TASK P WHERE P.PRIMARY_KEY=WF.PRIMARY_KEY AND P.ORGAN_ID=WF.ORGAN_ID)");
		 sql.append(" AND  WF.ORGAN_ID =? AND WF.PROCESS_TYPE = ? AND WF.ACT_DEF_NAME IN ("+actDefName+")");
		 sql.append(" AND AA.RECORD_ID = TA.RECORD_ID");
		 typeList.add(Types.VARCHAR);
		 argsList.add(organId);
		 typeList.add(Types.VARCHAR);
		 argsList.add(procTypeId);
		 //拆分自定义查询字段
		 if(mysetwhere1 !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere1,typeList,argsList,sql);
		 }
//		 sql.append(" ORDER BY W.END_TIME DESC");
		 
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	}
	
}
