package com.inspur.cams.drel.surey.assistance.dao.jdbc;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.surey.assistance.dao.ISamSureyWfAssistanceHisDao;
import com.inspur.cams.drel.surey.assistance.data.SamSureyWfAssistanceHis;


/**
 * @title:SamSureyWfAssitanceHisDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 public class SamSureyWfAssistanceHisDao extends EntityDao<SamSureyWfAssistanceHis> implements ISamSureyWfAssistanceHisDao{

 	public SamSureyWfAssistanceHisDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamSureyWfAssistanceHis.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamSureyWfAssitanceHis");
	}
   
   public DataSet queryByFlowId(ParameterSet pset){
	   String flowId=(String)pset.getParameter("FLOW_ID");
	   StringBuffer sql=new StringBuffer();
	   if(StringUtils.isNotEmpty(flowId)){
		   sql.append("SELECT ah.SURVEY_RESULT SURVEY_RESULT,ah.SIGN_ORGAN SIGN_ORGAN,ah.SIGN_DATE SIGN_DATE,wh.ACTIVITY_ORGAN_NAME ACTIVITY_ORGAN_NAME FROM SAM_SUREY_WF_ASSISTANCE_HIS ah,SAM_SUREY_WF_HIS wh where ah.HIS_ID=wh.HIS_ID   ");
		   sql.append(" AND ah.HIS_ID in( ");
		   sql.append("  SELECT HIS_ID FROM SAM_SUREY_WF_HIS WHERE FLOW_ID='");
		   sql.append(flowId);
		   sql.append("' union ");
		   sql.append("SELECT HIS_ID FROM SAM_SUREY_WF_HIS WHERE FLOW_ID in (SELECT FLOW_ID FROM SAM_SUREY_WF WHERE PARENT_FLOW_ID='");
		   sql.append(flowId);
		   sql.append("'))");  
		   
	   }
	   return executeDataset(sql.toString(), pset.getPageStart(), pset.getPageLimit(), true);
   }
   
}
