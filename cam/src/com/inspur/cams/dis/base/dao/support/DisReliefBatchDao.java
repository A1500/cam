package com.inspur.cams.dis.base.dao.support;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Set;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.PubUtils;
import com.inspur.cams.dis.base.dao.IDisReliefBatchDao;
import com.inspur.cams.dis.base.data.DisReliefBatch;
import com.inspur.cams.dis.base.data.DisReliefBatchDetail;
/**
 * @title:DisReliefBathDao
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
 public class DisReliefBatchDao extends EntityDao<DisReliefBatch> implements IDisReliefBatchDao{

 	

  	@Override
	public Class getEntityClass() {
		return DisReliefBatch.class;
	}
  	/**
	  * 查询批次信息
	 * @param pset
	 * @return
	 */
 	public DataSet queryBatch(ParameterSet pset){
 		String requiredOrganCode = (String) pset.getParameter("requiredOrganCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.BATCH_ID, T.RELIEF_TYPE ,T.YEAR,  T.BATCH_NAME, T.AREA_CODE, T.CREATE_ORGAN,\n");
		sql.append("       T.CREATE_PERSON, T.CREATE_TIME, T.CREATE_ORGAN_CODE,C.FULL_NAME as CREATE_ORGAN_NAME\n"); 
		sql.append("  FROM DIS_RELIEF_BATCH T, DIC_CITY C\n"); 
		sql.append(" WHERE T.CREATE_ORGAN_CODE = C.ID  ");
		List<Object> o= PubUtils.queryUitl(sql,pset,requiredOrganCode,"T.CREATE_ORGAN_CODE",null,null);
		
		if(pset.containsKey("limit")){
			return this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), pset.getPageStart(), pset.getPageLimit(), true);
		}else{
			return this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), true);
		}
 	}
	/**
	  * 查询批次信息
	 * @param pset
	 * @return
	 */
	public DataSet queryBatchForRoster(ParameterSet pset){
		String requiredOrganCode = (String) pset.getParameter("requiredOrganCode");
		StringBuffer sql = new StringBuffer();

		sql.append("select batch_id, detail_pid, relief_type, batch_name, \n");
		sql.append("area_code, area_name, create_organ,  create_person, create_time, year, \n"); 
		sql.append(" create_organ_code, fill_state, approval_food, \n"); 
		sql.append(" approval_clothes, approval_rebuiled_house, \n"); 
		sql.append(" approval_repaired_house, approval_monry  from v_statis_dis_batch_info  where 1=1");
		List<Object> o= PubUtils.queryUitl(sql,pset,requiredOrganCode,"CREATE_ORGAN_CODE",null,null);
		
		if(pset.containsKey("limit")){
			return this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), pset.getPageStart(), pset.getPageLimit(), true);
		}else{
			return this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), true);
		}
	}
 	/**
	 * 查询统计批次记录
	 * @param pset
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryBatchStatis(ParameterSet pset) {
		/*String year = (String) pset.getParameter("YEAR");
		String createOrganCode = (String) pset.getParameter("CREATE_ORGAN_CODE");
		String reliefType = (String) pset.getParameter("RELIEF_TYPE");*/
		StringBuilder sb = new StringBuilder();
		sb.append("select * from v_statis_dis_batch_info v ")
			.append(" where v.fill_state = '").append(DisReliefBatchDetail.FILL_STATE_WC).append("'");
		Set<String> keySet = pset.keySet();
		for(String key : keySet) {
			if(key.contains("@")) {
				String[] keys = key.split("@");
				String marker = " and ";
				if(keys.length == 3) {
					marker = keys[2];
				}
 				String value = (String)pset.getParameter(key);
				if(!PubUtils.isEmpty(value)) {
					sb.append(marker).append(keys[0]).append(" ").append(keys[1]).append(" '").append(value).append("'");
				}
			}
		}
		/*
		if(!PubUtils.isEmpty(year)) {
			sb.append(" and v.year = ").append(year);
		}
		
		if(!PubUtils.isEmpty(createOrganCode)) {
			sb.append(" and v.create_organ_code = '").append(createOrganCode).append("' ");
		}
		
		if(!PubUtils.isEmpty(reliefType)) {
			sb.append(" and v.relief_type = '").append(reliefType).append("' ");
		}
		
		*/
		sb.append(" order by v.year desc");
		
		DataSet ds = this.executeDataset(sb.toString(), pset.getPageStart(), pset.getPageLimit(), true);
		return ds;
	}
}
