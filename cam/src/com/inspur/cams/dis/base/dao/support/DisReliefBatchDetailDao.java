package com.inspur.cams.dis.base.dao.support;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.PubUtils;
import com.inspur.cams.dis.base.dao.IDisReliefBatchDetailDao;
import com.inspur.cams.dis.base.data.DisReliefBatchDetail;
/**
 * @title:DisReliefBathDao
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
 @SuppressWarnings("unchecked")
 public class DisReliefBatchDetailDao extends EntityDao<DisReliefBatchDetail> implements IDisReliefBatchDetailDao{

	@Override
	public Class getEntityClass() {
		return DisReliefBatchDetail.class;
	}
  	/**
	 * 根据批次id查询批次详细信息
	 */
	public DataSet queryBatchDetailByDetailId(ParameterSet pSet) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.BATCH_DETAIL_ID, T.RELIEF_TYPE , T.YEAR,T.BATCH_ID, T.BATCH_NAME, T.REQUIRED_ORGAN_CODE, T.REQUIRED_ORGAN_NAME,\n");
		sql.append("       T.FILL_STATE, T.FILL_PEOPLE, FILL_TIME,C.FULL_NAME\n"); 
		sql.append("  FROM DIS_RELIEF_BATCH_DETAIL T, DIC_CITY C\n"); 
		sql.append(" WHERE T.REQUIRED_ORGAN_CODE = C.ID AND T.BATCH_ID=?");
		if(pSet.containsKey("limit")){
			return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{pSet.get("batchId")}, pSet.getPageStart(), pSet.getPageLimit(), true);
		}else{
			return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{pSet.get("batchId")}, true);
		}
		
	}
	/**
	 * 根据批次DetailId和所需填报单位区划requiredOrganCode删除批次详细信息
	 */
	public void deleteByDetailIdOrganCode(String DetailId,String requiredOrganCode){
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE  DIS_RELIEF_BATCH_DETAIL WHERE REQUIRED_ORGAN_CODE =? AND BATCH_ID=?\n");
		this.executeUpdate(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{requiredOrganCode,DetailId});
	}
	
	public DataSet queryBatchDetail(ParameterSet pset){
		//List<Integer> typeList = new ArrayList<Integer>();
		//List<Object> argsList = new ArrayList<Object>();
		String requiredOrganCode = (String) pset.getParameter("requiredOrganCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.BATCH_DETAIL_ID, T.RELIEF_TYPE , T.YEAR, T.BATCH_ID, T.BATCH_NAME, T.REQUIRED_ORGAN_CODE, T.REQUIRED_ORGAN_NAME,\n");
		sql.append("       T.FILL_STATE, T.FILL_PEOPLE, FILL_TIME,C.FULL_NAME\n"); 
		sql.append("  FROM DIS_RELIEF_BATCH_DETAIL T, DIC_CITY C\n"); 
		sql.append(" WHERE T.REQUIRED_ORGAN_CODE = C.ID ");
		List<Object> o= PubUtils.queryUitl(sql,pset,requiredOrganCode,"T.REQUIRED_ORGAN_CODE",null,null);
		
		o.set(0, (String) o.get(0) + " ORDER BY T.FILL_TIME DESC, T.BATCH_DETAIL_ID");
		if(pset.containsKey("limit")){
			return this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), pset.getPageStart(), pset.getPageLimit(), true);
		}else{
			return this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), true);
		}
	}
	/**
	 * 查询批次（冬春生活，因灾死亡，灾区民房）
	 * @param pset
	 * @return
	 */
	public DataSet queryAssistanceBatch(ParameterSet pset){
		String batchId = (String) pset.getParameter("batchId");   //批次编号
		String batchName = (String) pset.getParameter("batchName"); //批次名称
		String reliefType = (String)pset.getParameter("reliefType");//查询条件：救助类型
		String fillState = (String)pset.getParameter("fillState");
		String requiredOrganCode = (String)pset.getParameter("requiredOrganCode");//查询条件：所需填报单位区划
		requiredOrganCode = PubUtils.isEmpty(requiredOrganCode) ? BspUtil.getOrganCode() : requiredOrganCode;
		
		StringBuffer sql = new StringBuffer();//新建sql查询语句
		List<Integer> typeList = new ArrayList<Integer>();//executeDataset参数
		List<Object> argsList = new ArrayList<Object>();//executeDataset参数
		sql.append("SELECT T.BATCH_DETAIL_ID, T.RELIEF_TYPE , T.BATCH_ID, T.BATCH_NAME, T.REQUIRED_ORGAN_CODE, T.REQUIRED_ORGAN_NAME,\n");
		sql.append("       T.FILL_STATE, T.FILL_PEOPLE, t.FILL_TIME \n"); 
		sql.append("  FROM DIS_RELIEF_BATCH_DETAIL T \n"); 
		sql.append(" where 1=1 and t.fill_state in ( '").append(DisReliefBatchDetail.FILL_STATE_XJ).append("', '").append(DisReliefBatchDetail.FILL_STATE_LR).append("') ");
		if(StringUtils.isNotEmpty(reliefType)){
			sql.append(" and t.relief_type=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(reliefType);
		}
		
		if(!PubUtils.isEmpty(batchId)) {
			sql.append(" and t.batch_id like ? ");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+batchId+"%");
		}
		
		if(!PubUtils.isEmpty(batchName)) {
			sql.append(" and t.batch_name like ?");
			typeList.add(Types.VARCHAR);
			argsList.add("%"+batchName+"%");
		}
		
		if(!PubUtils.isEmpty(fillState)) {
			sql.append(" and t.fill_state = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(fillState);
		}
		
		int index = 12;
		if ("0000000000".equals(requiredOrganCode.substring(2,12))) {
			index = 2;
		} else if ("00000000".equals(requiredOrganCode.substring(4,12))) {
			index = 4;
		} else if ("000000".equals(requiredOrganCode.substring(6,12))){
			index = 6;
		} else if ("000".equals(requiredOrganCode.substring(9,12))){
			index = 9;
		}
		
		sql.append(" and rpad(substr(t.required_Organ_Code,1," +index+ "),12,0)=? ");// 省局
		typeList.add(Types.VARCHAR);
		argsList.add(requiredOrganCode);
		
		sql.append(" order by t.fill_state asc,t.fill_time desc");
		int[] types = new int[typeList.size()];//参数设置
		for(int i=0;i<typeList.size();i++){
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();//参数设置
		String ifAll = (String) pset.getParameter("ifAll");
		DataSet dSet = new DataSet();
		if(StringUtils.isNotEmpty(ifAll)){
			dSet = executeDataset(sql.toString(), types, args, true);
		}else{
			dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), true);
		}
		return dSet;
	}
	
	/**
	 * 把主键为batchDetailId的批次明细添加上字段填报状态，填报人，填报时间
	 */
	public void selectBatch(String batchDetailId){
		StringBuffer sql = new StringBuffer();
		sql.append("update DIS_RELIEF_BATCH_DETAIL\n");
		sql.append("set fill_state = '2'");
		sql.append(" , fill_people = '").append(GetBspInfo.getBspInfo().getUserName()).append("'");
		sql.append(" , fill_time = '").append(DateUtil.getTime()).append("'");
		sql.append("where batch_detail_id = '").append(batchDetailId).append("'");
		executeUpdate(sql.toString());
	}
	/**
	 * 根据批次DetailId和所需填报单位区划requiredOrganCode删除批次详细信息
	 */
	public void deleteByBatchId(String BatchId){
		StringBuffer sql = new StringBuffer();
		sql.append("DELETE  DIS_RELIEF_BATCH_DETAIL WHERE BATCH_ID=?\n");
		this.executeUpdate(sql.toString(),new int[]{Types.VARCHAR},new Object[]{BatchId});
	}
	
	/**
	 * 救灾批次明细查询
	 * @param pset
	 * @return
	 */
	public DataSet queryDetail(ParameterSet pset) {
		String batchId = (String) pset.getParameter("batchId");   //批次编号
		String reliefType = (String)pset.getParameter("reliefType");//查询条件：救助类型
		String fillState = (String)pset.getParameter("fillState");
		String requiredOrganCode = (String)pset.getParameter("requiredOrganCode");//查询条件：所需填报单位区划（登录人可以查看的区域 ）
		requiredOrganCode = PubUtils.isEmpty(requiredOrganCode) ? BspUtil.getOrganCode() : requiredOrganCode;
		String organCode = (String) pset.getParameter("organCode"); //所需填报单位区划
		
		StringBuffer sql = new StringBuffer();//新建sql查询语句
		List<Integer> typeList = new ArrayList<Integer>();//executeDataset参数
		List<Object> argsList = new ArrayList<Object>();//executeDataset参数
		sql.append("SELECT * "); 
		sql.append("  FROM v_statis_dis_batch_detail_info T "); 
		sql.append(" where 1=1 and t.fill_state = '").append(DisReliefBatchDetail.FILL_STATE_WC).append("'");
		if(StringUtils.isNotEmpty(reliefType)){
			sql.append(" and t.relief_type=? ");
			typeList.add(Types.VARCHAR);
			argsList.add(reliefType);
		}
		
		if(!PubUtils.isEmpty(batchId)) {
			sql.append(" and t.batch_id = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(batchId);
		}
		
		if(!PubUtils.isEmpty(fillState)) {
			sql.append(" and t.fill_state = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(fillState);
		}
		
		if(!PubUtils.isEmpty(organCode)) {
			sql.append(" and t.required_Organ_Code = ?");
			typeList.add(Types.VARCHAR);
			argsList.add(organCode);
		} else {
			int index = 12;
			if ("0000000000".equals(requiredOrganCode.substring(2,12))) {
				index = 2;
			} else if ("00000000".equals(requiredOrganCode.substring(4,12))) {
				index = 4;
			} else if ("000000".equals(requiredOrganCode.substring(6,12))){
				index = 6;
			} else if ("000".equals(requiredOrganCode.substring(9,12))){
				index = 9;
			}
			
			sql.append(" and rpad(substr(t.required_Organ_Code,1," +index+ "),12,0)=? ");// 省局
			typeList.add(Types.VARCHAR);
			argsList.add(requiredOrganCode);
		}
		
		sql.append(" order by t.fill_time desc");
		int[] types = new int[typeList.size()];//参数设置
		for(int i=0;i<typeList.size();i++){
			types[i] = typeList.get(i);
		}
		Object[] args = argsList.toArray();//参数设置
		String ifAll = (String) pset.getParameter("ifAll");
		DataSet dSet = new DataSet();
		if(StringUtils.isNotEmpty(ifAll)){
			dSet = executeDataset(sql.toString(), types, args, true);
		}else{
			dSet = executeDataset(sql.toString(), types, args,pset.getPageStart(),pset.getPageLimit(), true);
		}
		return dSet;
	}
}
