package com.inspur.cams.fis.base.dao.jdbc;


import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import java.math.BigDecimal;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.workflow.taskinfo.util.QueryConditionUtil;
import com.inspur.cams.fis.base.dao.IFisCemeApplyInfoDao;
import com.inspur.cams.fis.base.data.FisCemeApplyInfo;

/**
 * 公墓审批业务表dao
 * 
 * @author
 * @date 2013-08-01
 */
public class FisCemeApplyInfoDao extends EntityDao<FisCemeApplyInfo> implements
		IFisCemeApplyInfoDao {


	@Override
	public Class<FisCemeApplyInfo> getEntityClass() {
		return FisCemeApplyInfo.class;
	}

	@SuppressWarnings("unchecked")
	public DataSet queryCreate(ParameterSet pset){
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String applyFlag=(String)pset.getParameter("applyFlag");
		 String prop=(String)pset.getParameter("prop");
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT ");
		 sql.append("T.CEME_APPLY_ID, F.RECORD_ID, F.NAME ,F.CREATE_TIME , T.APPLY_FLAG ,T.APPLY_STATE, T.IS_REPORT , T.REC_TIME ,  T.COM_TIME ,T.CUR_ACTIVITY , T.CUR_ORGAN ,T.FILL_ORGAN_NAME");
		 sql.append(" FROM  FIS_CEME_INFO F , FIS_CEME_APPLY_INFO T");
		 sql.append(" WHERE T.RECORD_ID=F.RECORD_ID AND T.APPLY_FLAG= ? AND F.PROP= ?");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(applyFlag);
		 typeList.add(Types.VARCHAR);
		 argsList.add(prop);
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
		 }
		 sql.append(" ORDER BY F.NAME DESC");
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
//		 System.out.println(sql.toString());
 		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	}

	//年检业务首页显示的信息 流程发起页面 待办任务
	public DataSet queryDaiban(ParameterSet pset) {
		String prop = "2";//经营性公墓
		String organCode = (String)pset.getParameter("organCode");
		String name = (String)pset.getParameter("Name");
		String queryTime = (String)pset.getParameter("queryTime");
		String checkResult = (String)pset.getParameter("checkResult");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select D.RECORD_ID,D.ORGAN_ID,D.NAME,E.APPLY_STATE,E.CHECK_YEAR,E.CHECK_RESULT,E.CEME_APPLY_ID,E.APPLY_FLAG,E.FILL_ORGAN_NAME,E.SECOND_TIME ");
		sql.append(",E.FIRST_TIME,E.REC_TIME,E.COM_TIME,E.IS_REPORT,E.CUR_ACTIVITY,E.CUR_ORGAN,F.SCORE_ID FROM FIS_CEME_INFO D , FIS_CEME_APPLY_INFO E , FIS_CEME_CHECK_SCORE F WHERE ");
		sql.append("D.RECORD_ID = E.RECORD_ID AND E.CEME_APPLY_ID = F.CEME_APPLY_ID AND D.PROP = ?");
		objList.add(prop);
		typeList.add(Types.VARCHAR);
		if (StringUtils.isNotEmpty(organCode)) {
			sql.append(" AND D.MANA_LEVEL_ID =?  ");
			objList.add(organCode);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" and D.NAME LIKE ?  ");
			objList.add(name);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(checkResult)) {
			sql.append(" and E.CHECK_RESULT=?  ");
			objList.add(checkResult);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(queryTime)) {
			sql.append(" and E.CHECK_YEAR=?  ");
			objList.add(queryTime);
			typeList.add(Types.VARCHAR);
		}
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
	
	//公益性年检
	public DataSet queryPublic(ParameterSet pset){
		String prop = "1";//公益性公墓
		String organCode = (String)pset.getParameter("organCode");
		String name = (String)pset.getParameter("Name");
		String queryTime = (String)pset.getParameter("queryTime");
		String checkResult = (String)pset.getParameter("checkResult");
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> objList = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer();
		sql.append("select D.RECORD_ID,D.ORGAN_ID,D.NAME,E.REC_TIME,E.COM_TIME,E.CUR_ORGAN,E.APPLY_STATE,E.CHECK_YEAR,E.CHECK_RESULT,E.CEME_APPLY_ID,E.APPLY_FLAG");
		sql.append(",E.IS_REPORT,F.SCORE_ID FROM FIS_CEME_INFO D , FIS_CEME_APPLY_INFO E , FIS_CEME_CHECK_SCORE F WHERE ");
		sql.append("D.RECORD_ID = E.RECORD_ID AND E.CEME_APPLY_ID = F.CEME_APPLY_ID AND D.PROP = ?");
		objList.add(prop);
		typeList.add(Types.VARCHAR);
		if (StringUtils.isNotEmpty(organCode)) {
			sql.append(" AND D.MANA_LEVEL_ID =?  ");
			objList.add(organCode);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" and D.NAME LIKE ?  ");
			objList.add(name);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(checkResult)) {
			sql.append(" and E.CHECK_RESULT=?  ");
			objList.add(checkResult);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(queryTime)) {
			sql.append(" and E.CHECK_YEAR=?  ");
			objList.add(queryTime);
			typeList.add(Types.VARCHAR);
		}
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
	
	public DataSet queryCeme(ParameterSet pset) {
		String name = (String) pset.getParameter("NAME");
		String fillOrganCode = (String) pset.getParameter("FILL_ORGAN_CODE");
		String isReport = (String) pset.getParameter("IS_REPORT");
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select i.RECORD_ID,i.ORGAN_ID,i.NAME,a.CEME_APPLY_ID,c.CHANGE_ID from FIS_CEME_APPLY_INFO a , FIS_CEME_INFO i ,FIS_CEME_CHANGE c ");
		sql.append(" where 1=1 and a.RECORD_ID = i.RECORD_ID and a.CEME_APPLY_ID = c.CEME_APPLY_ID ");
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" and i.NAME like ? ");
			argsList.add(name+'%');
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(fillOrganCode)) {
			sql.append(" and a.FILL_ORGAN_CODE = ? ");
			argsList.add(fillOrganCode);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(isReport)) {
			sql.append(" and a.IS_REPORT = ? ");
			argsList.add(isReport);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args,
				getDsStart(pset), getDsLimit(pset), true);
		return ds;
	}
	
	public DataSet queryCemeApply(ParameterSet pset) {
		String name = (String) pset.getParameter("NAME");
		String fillOrganCode = (String) pset.getParameter("FILL_ORGAN_CODE");
		String applyFlag = (String) pset.getParameter("APPLY_FLAG");
		String isReport = (String) pset.getParameter("IS_REPORT");
		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select a.* from FIS_CEME_APPLY_INFO a , FIS_CEME_INFO i ");
		sql.append(" where 1=1 and a.RECORD_ID = i.RECORD_ID");
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" and i.NAME like ? ");
			argsList.add('%'+name+'%');
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(applyFlag)) {
			sql.append(" and a.APPLY_FLAG = ? ");
			argsList.add(applyFlag);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(fillOrganCode)) {
			sql.append(" and a.FILL_ORGAN_CODE = ? ");
			argsList.add(fillOrganCode);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(isReport)) {
			sql.append(" and a.IS_REPORT = ? ");
			argsList.add(isReport);
			typeList.add(Types.VARCHAR);
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args,
				getDsStart(pset), getDsLimit(pset), true);
		return ds;
	}

	public DataSet queryPreOrganId(ParameterSet pset){
		 StringBuffer sql = new StringBuffer();
		 String cemeApplyId=(String)pset.getParameter("cemeApplyId");
		 String actDefName=(String)pset.getParameter("actDefName");
//		 System.out.println(pset.getPageStart());
//		 System.out.println(pset.getPageLimit());
		 sql.append("SELECT ");
		 sql.append("Y.*  FROM  WF_YI_BAN_TASK Y, WF_DAI_BAN_TASK D ");
		 sql.append(" WHERE D.PRIMARY_KEY=Y.PRIMARY_KEY AND Y.ACT_DEF_NAME= ? AND D.PRIMARY_KEY= ? ");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(actDefName);
		 typeList.add(Types.VARCHAR);
		 argsList.add(cemeApplyId);
		
		 //拆分自定义查询字段
		 sql.append(" ORDER BY Y.CREATE_TIME DESC");
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
		return this.executeDataset(sql.toString(), types, args, 0, 2, true);
		
	}

	/**
	 * @Title: getDsStart
	 * @Description: TODO(excel分页信息A)
	 * @author wangziming
	 */
	private int getDsStart(ParameterSet pset) {
		String excelType = (String) pset.getParameter("excelType");
		if (null == excelType || "0,1".indexOf(excelType) == -1) {
			return pset.getPageStart();
		}
		int start = 0;
		if ("0".equals(excelType)) { // 导出当前页
			Integer startExcel = (java.lang.Integer) pset
					.getParameter("startExcel");
			if (startExcel != null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}

	/**
	 * @Title: getDsLimit
	 * @Description: TODO(excel分页信息B)
	 * @author wangziming
	 */
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String) pset.getParameter("excelType");
		if (null == excelType || "0,1".indexOf(excelType) == -1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel"))
				.intValue();
		return limit;
	}

	private String getAreaCodeLikePrefix(String areaCode) {
		if (areaCode.endsWith("0000000000")) {// 省370000000000
			return areaCode.substring(0, 2);
		} else if (areaCode.endsWith("00000000")) {// 市370100000000
			return areaCode.substring(0, 4);
		} else if (areaCode.endsWith("000000")) {// 县370104000000
			return areaCode.substring(0, 6);
		} else if (areaCode.endsWith("000")) {// 乡370104003000
			return areaCode.substring(0, 9);
		}
		return areaCode;
	}

	public void cemeLogoffDelete(ParameterSet pset) {
		String cemeApplyId = (String) pset.getParameter("cemeApplyId");
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM FIS_CEME_LOGOFF WHERE CEME_APPLY_ID = '"+cemeApplyId+"'");
		StringBuffer sql1 = new StringBuffer();
		sql1.append("DELETE FROM FIS_CEME_LOGOFF_OPINION WHERE CEME_APPLY_ID = '"+cemeApplyId+"'");
		StringBuffer sql2 = new StringBuffer();
		sql2.append("DELETE FROM FIS_CEME_ACCESSORIES WHERE ITEM_ID = '"+cemeApplyId+"'");
		StringBuffer sql3 = new StringBuffer();
		sql3.append("DELETE FROM FIS_CEME_CHECK_HISTORY WHERE CEME_APPLY_ID = '"+cemeApplyId+"'");
		executeUpdate(sql.toString());
		executeUpdate(sql1.toString());
		executeUpdate(sql2.toString());
		executeUpdate(sql3.toString());
	}
	public void deleteAll(ParameterSet pset){
		String cemeApplyId = (String) pset.getParameter("cemeApplyId");
		StringBuffer sql = new StringBuffer();
		StringBuffer sFuJian = new StringBuffer();
		sFuJian.append("DELETE FROM FIS_CEME_ACCESSORIES WHERE ITEM_ID = '"+cemeApplyId+"'");
		sql.append("DELETE FROM FIS_CEME_CHECK_HISTORY T WHERE T.CEME_APPLY_ID = '"+cemeApplyId+"'");
		executeUpdate(sql.toString());
		executeUpdate(sFuJian.toString());
	}

	public DataSet queryByCurActicity(ParameterSet pset) {
		String name = (String) pset.getParameter("NAME");
		String fillOrganCode = (String) pset.getParameter("FILL_ORGAN_CODE");
		String applyFlag = (String) pset.getParameter("APPLY_FLAG");
		String curActivity = (String) pset.getParameter("CUR_ACTIVITY");
		String prop = (String) pset.getParameter("PROP");

		StringBuffer sql = new StringBuffer();
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		sql.append(" select a.* from FIS_CEME_APPLY_INFO a , FIS_CEME_INFO i ");
		sql.append(" where 1=1 and a.RECORD_ID = i.RECORD_ID");
		
		if (StringUtils.isNotEmpty(name)) {
			sql.append(" and i.NAME like ? ");
			argsList.add('%'+name+'%');
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(applyFlag)) {
			sql.append(" and a.APPLY_FLAG = ? ");
			argsList.add(applyFlag);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(fillOrganCode)) {
			sql.append(" and a.FILL_ORGAN_CODE = ? ");
			argsList.add(fillOrganCode);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(prop)) {
			sql.append(" and i.PROP = ? ");
			argsList.add(prop);
			typeList.add(Types.VARCHAR);
		}
		if (StringUtils.isNotEmpty(curActivity)) {
			sql.append(" and a.CUR_ACTIVITY = ? ");
			argsList.add(curActivity);
			typeList.add(Types.VARCHAR);
		}else{
			sql.append(" and a.CUR_ACTIVITY != '变更备案' ");
		}
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds = executeDataset(sql.toString(), types, args,
				getDsStart(pset), getDsLimit(pset), true);
		return ds;
	}
	public void deleteCreate(ParameterSet pset){
		String cemeApplyId = (String) pset.getParameter("cemeApplyId");
		String recordId = (String) pset.getParameter("recordId");

		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM FIS_CEME_APPLY_INFO WHERE CEME_APPLY_ID = '"+cemeApplyId+"'");
		StringBuffer sql1 = new StringBuffer();
		sql1.append("DELETE FROM FIS_CEME_LOGOFF_OPINION WHERE CEME_APPLY_ID = '"+cemeApplyId+"'");
		StringBuffer sql2 = new StringBuffer();
		sql2.append("DELETE FROM FIS_CEME_ACCESSORIES WHERE ITEM_ID = '"+cemeApplyId+"'");
		StringBuffer sql3 = new StringBuffer();
		sql3.append("DELETE FROM FIS_CEME_INFO WHERE RECORD_ID = '"+recordId+"'");
		StringBuffer sql4 = new StringBuffer();
		sql4.append("DELETE FROM fis_ceme_check_history WHERE CEME_APPLY_ID = '"+recordId+"'");
		executeUpdate(sql.toString());
		executeUpdate(sql1.toString());
		executeUpdate(sql2.toString());
		executeUpdate(sql3.toString());
		executeUpdate(sql4.toString());
		
	}
	/**
	 * 查询业务表,公墓表和扩建表方法
	 * @param pset
	 * @return
	 */
	public DataSet queryExpend(ParameterSet pset){
		QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String applyFlag=(String)pset.getParameter("applyFlag");
		 String prop=(String)pset.getParameter("prop");
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 StringBuffer sql = new StringBuffer();
		 sql.append("SELECT ");
		 sql.append("T.CEME_APPLY_ID, F.RECORD_ID, F.NAME ,F.CREATE_TIME , T.APPLY_FLAG ,T.APPLY_STATE, T.IS_REPORT , T.REC_TIME ,  T.COM_TIME ,T.CUR_ACTIVITY , T.CUR_ORGAN ,T.FILL_ORGAN_NAME");
		 sql.append(" FROM  FIS_CEME_INFO F , FIS_CEME_EXPEND_INFO E , FIS_CEME_APPLY_INFO T");
		 sql.append(" WHERE E.RECORD_ID=T.RECORD_ID AND E.CEME_ID=F.RECORD_ID AND T.APPLY_FLAG= ? AND F.PROP= ?");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(applyFlag);
		 typeList.add(Types.VARCHAR);
		 argsList.add(prop);
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
		 }
		 sql.append(" ORDER BY F.NAME DESC");
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
//		 System.out.println(sql.toString());
		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
		
	}
	public void deleteExpend(ParameterSet pset){
		String cemeApplyId = (String) pset.getParameter("cemeApplyId");
		String recordId = (String) pset.getParameter("recordId");

		StringBuffer sql = new StringBuffer();
		sql.append("DELETE FROM FIS_CEME_APPLY_INFO WHERE CEME_APPLY_ID = '"+cemeApplyId+"'");
		StringBuffer sql1 = new StringBuffer();
		sql1.append("DELETE FROM FIS_CEME_LOGOFF_OPINION WHERE CEME_APPLY_ID = '"+cemeApplyId+"'");
		StringBuffer sql2 = new StringBuffer();
		sql2.append("DELETE FROM FIS_CEME_ACCESSORIES WHERE ITEM_ID = '"+cemeApplyId+"'");
		StringBuffer sql3 = new StringBuffer();
		sql3.append("DELETE FROM FIS_CEME_EXPEND_INFO WHERE RECORD_ID = '"+recordId+"'");
		StringBuffer sql4 = new StringBuffer();
		sql4.append("DELETE FROM fis_ceme_check_history WHERE CEME_APPLY_ID = '"+recordId+"'");
		executeUpdate(sql.toString());
		executeUpdate(sql1.toString());
		executeUpdate(sql2.toString());
		executeUpdate(sql3.toString());
		executeUpdate(sql4.toString());
		
	}
	public void deleteAcceptance(ParameterSet pset) {
		// TODO Auto-generated method stub
		String cemeApplyId=(String) pset.getParameter("cemeApplyId");
		String recordId=(String) pset.getParameter("recordId");
		
		StringBuffer sql=new StringBuffer();
		sql.append("DELETE FROM FIS_CEME_APPLY_INFO WHERE CEME_APPLY_ID='"+cemeApplyId+"'");
/*		StringBuffer sql1=new StringBuffer();
		sql1.append("DELETE FROM FIS_CEME_INFO WHERE RECORD_ID='"+recordId+"'");*/
		StringBuffer sql2=new StringBuffer();
		sql2.append("delete from fis_ceme_check_history where record_Id='"+recordId+"'");
		executeUpdate(sql.toString());
	//	executeUpdate(sql1.toString());
		executeUpdate(sql2.toString());
	}
	/*
	 * 查询验收业务
	 * */
	@SuppressWarnings("unchecked")
	public DataSet queryYS(ParameterSet pset){
		 QueryConditionUtil queryConditionUtil = new QueryConditionUtil();
		 String applyFlag=(String)pset.getParameter("applyFlag");
		 String prop=(String)pset.getParameter("prop");
		 String mysetwhere=(String)pset.getParameter("mysetwhere");
		 StringBuffer sql = new StringBuffer();

		 sql.append("SELECT ");
		 sql.append("T.CEME_APPLY_ID, F.RECORD_ID, F.NAME ,F.CREATE_TIME , T.APPLY_FLAG ,T.APPLY_STATE, T.IS_REPORT , T.REC_TIME ,  T.COM_TIME ,T.CUR_ACTIVITY , T.CUR_ORGAN ,T.FILL_ORGAN_NAME");
		 sql.append(" FROM  FIS_CEME_INFO F , FIS_CEME_APPLY_INFO T");
		 sql.append(" WHERE T.RECORD_ID=F.RECORD_ID AND F.ORGAN_STATE='4' AND T.APPLY_FLAG= ? AND F.PROP= ?");
//		 sql.append(" WHERE T.RECORD_ID=F.RECORD_ID AND T.APPLY_FLAG= ? AND F.PROP= ?");
		 List typeList = new ArrayList();
		 List argsList = new ArrayList();
		 typeList.add(Types.VARCHAR);
		 argsList.add(applyFlag);
		 typeList.add(Types.VARCHAR);
		 argsList.add(prop);
		 if(mysetwhere !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
		 }
		 	 sql.append(" UNION " +
		 		"SELECT ");
		 sql.append("T.CEME_APPLY_ID, F.RECORD_ID, F.NAME ,F.CREATE_TIME , T.APPLY_FLAG ,T.APPLY_STATE, T.IS_REPORT , T.REC_TIME ,  T.COM_TIME ,T.CUR_ACTIVITY , T.CUR_ORGAN ,T.FILL_ORGAN_NAME");
		 sql.append(" FROM  FIS_CEME_INFO F , FIS_CEME_APPLY_INFO T, fis_ceme_expend_info E");
//		 sql.append(" WHERE T.RECORD_ID=E.RECORD_ID AND E.CEME_ID=F.RECORD_ID AND F.ORGAN_STATE=E.ORGAN_STATE AND F.ORGAN_STATE='6'AND T.APPLY_FLAG= ? AND F.PROP= ?");
		 sql.append(" WHERE T.RECORD_ID=E.RECORD_ID AND E.CEME_ID=F.RECORD_ID AND F.ORGAN_STATE=E.ORGAN_STATE AND T.APPLY_FLAG= ? AND F.PROP= ?");

		 typeList.add(Types.VARCHAR);
		 argsList.add(applyFlag);
		 typeList.add(Types.VARCHAR);
		 argsList.add(prop);
		 //拆分自定义查询字段
		 if(mysetwhere !=null ){
			 queryConditionUtil.buildAllConditionSql(mysetwhere,typeList,argsList,sql);
		 }
		 int[] types = new int[typeList.size()];
		 for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		 }
		 Object[] args = argsList.toArray(new Object[argsList.size()]);
 		 return this.executeDataset(sql.toString(), types, args, pset.getPageStart(), pset.getPageLimit(), true);
	}

}