package com.inspur.cams.prs.prsattachment.dao;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.prs.util.PrsSQL;

/**
 * @title:PrsAttachmentDao
 * @description:
 * @author:
 * @since:2011-08-31
 * @version:1.0
*/
 public class PrsAttachmentDao extends EntityDao<PrsAttachment> implements IPrsAttachmentDao{


	public PrsAttachmentDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class<PrsAttachment> getEntityClass() {
		return PrsAttachment.class;
	}

	public void batchDeleteByPoliciesId(String[] delIds) {
		for(int i=0;i<delIds.length;i++){
			executeUpdate(PrsSQL.DELETE_PRS_ATTACHMENT_BY_POLICIESID,new int[]{Types.VARCHAR},new Object[]{delIds[i]});
		}
	}
   
	public List<Map<String,Object>> queryByPoliciesRegId(String policiesRegId) {
		return executeQuery(PrsSQL.SELECT_ATTACHMENT_ID_PRS_ATTACHMENT_BY_POLICIES_REGULATIONS_ID,new int[]{Types.VARCHAR},new Object[]{policiesRegId});
	}
   /**
    * 附件下载
    */
	public List<Map<String,Object>> download(String id,String filename){
		return executeQuery(PrsSQL.SELECT_ATTACHMENT_PRS_ATTACHMENT_BY_ATTACHMENT_ID,new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{id,filename});
	}
}
