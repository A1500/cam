package com.inspur.cams.dis.base.dao.support;

import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.util.PubUtils;
import com.inspur.cams.dis.base.dao.IDisReliefInfoDao;
import com.inspur.cams.dis.base.data.DisReliefInfo;
/**
 * @title:DisReliefInfoDao
 * @description:
 * @author:
 * @since:2012-10-12
 * @version:1.0
*/
 public class DisReliefInfoDao extends EntityDao<DisReliefInfo> implements IDisReliefInfoDao{

 	public DisReliefInfoDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return DisReliefInfo.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from DisReliefInfo");
	}
   
   public DataSet queryList(ParameterSet pset) {
	   String batchDetailId = (String)pset.getParameter("batchDetailId");
	   String reliefType = (String)pset.getParameter("reliefType");
	   String recordId = (String)pset.getParameter("recordId");
	   String workflowstate = (String) pset.getParameter("workflowstate");
	   String acceptareacode = (String) pset.getParameter("acceptareacode");
	   
	   StringBuilder sb = new StringBuilder();
	   sb.append("select info.*, f.name name, f.id_card id_card from dis_relief_info info, dis_base_family_record f")
	   		.append(" where f.record_id(+) = info.info_id ");
	   
	   if(!PubUtils.isEmpty(batchDetailId)) {
		   sb.append(" and info.batch_detail_id = '").append(batchDetailId).append("' ");
	   }
	   
	   if(!PubUtils.isEmpty(recordId)) {
		   sb.append(" and info.record_id = '").append(recordId).append("' ");
	   }
	   
	   if(!PubUtils.isEmpty(reliefType)) {
		   sb.append(" and info.relief_type = '").append(reliefType).append("' ");
	   }
	   
	   if(!PubUtils.isEmpty(workflowstate)) {
		   sb.append(" and info.workflow_state = '").append(workflowstate).append("' ");
	   }
	   
	   if(!PubUtils.isEmpty(acceptareacode)) {
		   sb.append(" and info.accept_area_code = '").append(acceptareacode).append("' ");
	   }
	   DataSet ds = this.executeDataset(sb.toString(), pset.getPageStart(), pset.getPageLimit(), true);
	  
	   return ds;
   }
   /**
    * 根据主键为batchDetailId的批次修改状态成"1"(提交状态)
    * @param batchDetailId
    */
   public void selectBatch(String batchDetailId){
	   StringBuffer sql = new StringBuffer();//新建sql查询语句
	   sql.append("update DIS_RELIEF_INFO\n");
	   sql.append("set workflow_status = '1'\n"); 
	   sql.append("where batch_detail_id = '").append(batchDetailId).append("'");
	   executeUpdate(sql.toString());
   }
   /**
	 * 查询任务列表救灾的信息
	 * @param pset
	 * @return
	 */
  public DataSet queryTaskInfo(ParameterSet pset){
	   String requiredOrganCode = (String) pset.getParameter("requiredOrganCode");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT I.INFO_ID,I.BATCH_DETAIL_ID,I.RECORD_ID,I.FILL_TYPE,\n");
		sql.append("I.RELIEF_TYPE,I.WORKFLOW_STATUS,I.ACCEPT_AREA_NAME,\n"); 
		sql.append("I.APPROVAL_FAMILY_NUM,I.APPROVAL_TIMES,I.APPROVAL_FOOD,\n"); 
		sql.append("I.APPROVAL_CLOTHES,I.APPROVAL_REBUILED_HOUSE,I.APPROVAL_REPAIRED_HOUSE,I.APPROVAL_MONRY,\n"); 
		sql.append("Y.NAME,Y.ID_CARD,Y.FAMILY_TYPE,Y.TOWN_CODE,G.FULL_NAME AS TOWN_CODE_NAME \n"); 
		sql.append("FROM DIS_RELIEF_INFO I,DIS_BASE_FAMILY_RECORD Y, DIC_CITY G\n"); 
		sql.append(" WHERE I.RECORD_ID=Y.RECORD_ID(+)  AND Y.TOWN_CODE=G.ID(+)");
		List<Object> o= PubUtils.queryUitl(sql,pset,null,null,null,null);
		
		if(pset.containsKey("limit")){
			 DataSet ds = this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), pset.getPageStart(), pset.getPageLimit(), true);
			 return ds;
		}else{
			return this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), true);
		}
  }
  /**
	 * 获取各批次的核准信息及平均值
	 * @param pset
	 * @return
	 */
	public DataSet queryBatchGatherDate(ParameterSet pset) {
		 	String reliefType = (String) pset.getParameter("RELIEF_TYPE@=");
			StringBuffer sql = new StringBuffer();
			if("DC".equals(reliefType)||"CJ".equals(reliefType)||"SW".equals(reliefType)){
				sql.append("select COUNT(T.INFO_ID) FAMILY_AMOUNT ,\n");
				sql.append("       SUM(NVL(T.APPROVAL_FOOD, 0)) FOOD_AMOUNT,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_CLOTHES, 0)) CLOTHES_AMOUNT,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_REBUILED_HOUSE, 0)) REBUILED_HOUSE_AMOUNT,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_REPAIRED_HOUSE, 0)) REPAIRED_HOUSE_AMOUNT,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_MONRY, 0)) MONRY_AMOUNT,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_FOOD, 0))/COUNT(T.INFO_ID) FOOD_AVERAGE,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_CLOTHES, 0))/COUNT(T.INFO_ID) CLOTHES_AVERAGE,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_REBUILED_HOUSE, 0))/COUNT(T.INFO_ID) REBUILED_HOUSE_AVERAGE,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_REPAIRED_HOUSE, 0))/COUNT(T.INFO_ID) REPAIRED_HOUSE_AVERAGE,\n"); 
				sql.append("       SUM(NVL(T.APPROVAL_MONRY, 0))/COUNT(T.INFO_ID)  MONRY_AVERAGE\n"); 
				sql.append("  from dis_relief_info t\n"); 
				sql.append("  WHERE 1=1");
			}else if("YJ".equals(reliefType)||"GD".equals(reliefType)){
				sql.append("select   SUM(NVL(T.APPROVAL_FAMILY_NUM, 0)) FAMILY_AMOUNT,\n");
				sql.append("      SUM(NVL(T.APPROVAL_FOOD, 0)) FOOD_AMOUNT,\n"); 
				sql.append("      SUM(NVL(T.APPROVAL_CLOTHES, 0)) CLOTHES_AMOUNT,\n"); 
				sql.append("      SUM(NVL(T.APPROVAL_REBUILED_HOUSE, 0)) REBUILED_HOUSE_AMOUNT,\n"); 
				sql.append("      SUM(NVL(T.APPROVAL_REPAIRED_HOUSE, 0)) REPAIRED_HOUSE_AMOUNT,\n"); 
				sql.append("      SUM(NVL(T.APPROVAL_MONRY, 0)) MONRY_AMOUNT,\n"); 
				sql.append("      DECODE(SUM(NVL(T.APPROVAL_FAMILY_NUM, 0)),0,0,SUM(NVL(T.APPROVAL_FOOD, 0))/SUM(NVL(T.APPROVAL_FAMILY_NUM, 0))) FOOD_AVERAGE,\n"); 
				sql.append("      DECODE(SUM(NVL(T.APPROVAL_FAMILY_NUM, 0)),0,0,SUM(NVL(T.APPROVAL_CLOTHES, 0))/SUM(NVL(T.APPROVAL_FAMILY_NUM, 0))) CLOTHES_AVERAGE,\n"); 
				sql.append("      DECODE(SUM(NVL(T.APPROVAL_FAMILY_NUM, 0)),0,0,SUM(NVL(T.APPROVAL_REBUILED_HOUSE, 0))/SUM(NVL(T.APPROVAL_FAMILY_NUM, 0))) REBUILED_HOUSE_AVERAGE,\n"); 
				sql.append("      DECODE(SUM(NVL(T.APPROVAL_FAMILY_NUM, 0)),0,0,SUM(NVL(T.APPROVAL_REPAIRED_HOUSE, 0))/SUM(NVL(T.APPROVAL_FAMILY_NUM, 0))) REPAIRED_HOUSE_AVERAGE,\n"); 
				sql.append("      DECODE(SUM(NVL(T.APPROVAL_FAMILY_NUM, 0)),0,0,SUM(NVL(T.APPROVAL_MONRY, 0))/SUM(NVL(T.APPROVAL_FAMILY_NUM, 0))) MONRY_AVERAGE\n"); 
				sql.append(" from dis_relief_info t\n"); 
				sql.append("  WHERE 1=1");
			}
			List<Object> o= PubUtils.queryUitl(sql,pset,null,null,null,null);
			
			if(pset.containsKey("limit")){
				 DataSet ds = this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), pset.getPageStart(), pset.getPageLimit(), true);
				 return ds;
			}else{
				return this.executeDataset((String)o.get(0),(int[])o.get(1),(Object[])o.get(2), true);
			}
	}
}
