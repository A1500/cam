package com.inspur.cams.drel.esurey.dao.jdbc;

import org.apache.commons.lang.StringUtils;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.esurey.dao.ISamEsureyFeedbackDao;
import com.inspur.cams.drel.esurey.data.SamEsureyFeedback;

/**
 * @title:SamEsureyFeedbackDao
 * @description:
 * @author:
 * @since:2011-06-29
 * @version:1.0
*/
 public class SamEsureyFeedbackDao extends EntityDao<SamEsureyFeedback> implements ISamEsureyFeedbackDao{

 	public SamEsureyFeedbackDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SamEsureyFeedback.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SamEsureyFeedback");
	}
 //更新经济核对_外部单位填报信息表中提交标志
	public void updateCheckFlg(ParameterSet pset){
		StringBuffer sql=new StringBuffer();
		sql.append("update SAM_ESUREY_FEEDBACK \n");
		sql.append("set CHECK_FLG='"+1+"'\n");
		String checkOrg=(String)pset.getParameter("checkOrg");
		if(StringUtils.isNotEmpty(checkOrg)){
			sql.append(", CHECK_ORG='"+checkOrg+"'\n");
		}
		String feedbackId=(String)pset.getParameter("feedbackId");
		String checkPeople =(String) pset.getParameter("checkPeople");
		if(StringUtils.isNotEmpty(checkPeople)){
			sql.append(",CHECK_PEOPLE='" + checkPeople + "'\n");
		}
		String checkId =(String) pset.getParameter("checkId");
		if(StringUtils.isNotEmpty(checkId)){
			sql.append(",CHECK_ID='" + checkId + "'\n");
		}
		sql.append("where FEEDBACK_ID='"+feedbackId+"'");
		executeUpdate(sql.toString());
	}
}
