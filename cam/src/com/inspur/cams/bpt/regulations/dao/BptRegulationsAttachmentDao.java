package com.inspur.cams.bpt.regulations.dao;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.bpt.regulations.data.BptRegulationsAttachment;

@SuppressWarnings("unchecked")
 public class BptRegulationsAttachmentDao extends EntityDao<BptRegulationsAttachment> implements IBptRegulationsAttachmentDao{


	public BptRegulationsAttachmentDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

    @Override
	public Class<BptRegulationsAttachment> getEntityClass() {
		return BptRegulationsAttachment.class;
	}

	public void batchDeleteByRegulationId(String[] delIds) {
		for(int i=0;i<delIds.length;i++){
			executeUpdate("DELETE FROM BPT_REGULATIONS_ATTACHMENT WHERE REGULATIONS_ID=?",new int[]{Types.VARCHAR},new Object[]{delIds[i]});
		}
	}
   
	//删除附件记录
	public void deleteUploadFile(ParameterSet pset){
		String id = (String)pset.getParameter("id");
		String sql = "DELETE FROM BPT_REGULATIONS_ATTACHMENT T WHERE T.ATTACHMENT_ID = ? ";
		executeUpdate(sql, new int[]{Types.VARCHAR}, new Object[]{id});
	}
	
    public List<Map<String,Object>> queryByRegulationId(String regId) {
		StringBuffer sql=new StringBuffer();
		sql.append("SELECT ATTACHMENT_ID,FILE_NAME FROM BPT_REGULATIONS_ATTACHMENT WHERE REGULATIONS_ID=?");
		return executeQuery(sql.toString(),new int[]{Types.VARCHAR},new Object[]{regId});
	}
   /**
    * 附件下载
    */
	public List<Map<String,Object>> download(String id,String filename){
		StringBuffer sql=new StringBuffer();
		 sql.append("SELECT ATTACHMENT FROM BPT_REGULATIONS_ATTACHMENT WHERE ATTACHMENT_ID=?  AND FILE_NAME=? ");
		return executeQuery(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{id,filename});
	}
}
