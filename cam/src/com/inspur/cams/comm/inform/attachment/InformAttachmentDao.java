package com.inspur.cams.comm.inform.attachment;

import java.sql.Blob;
import java.util.List;
import java.util.Map;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:InInformAttachmentDao
 * @description:
 * @author:
 * @since:2009-10-27
 * @version:1.0
*/
 public class InformAttachmentDao extends EntityDao<InformAttachment> implements IInformAttachmentDao{

 	public InformAttachmentDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return InformAttachment.class;
	}
  	/**
	 * @description:删除通知附件
	 * @author huangqiqing
	 * @param String id[]
	 * @return int ，影响的记录行数
	 * @throws 无
	 * @since 2009-10-28
	 */
  	public int batchDeleteInformAttachment(String id[]){
  		StringBuffer sql=new StringBuffer();
  		sql.append("DELETE FROM APPROVALE_in_inform_attachment WHERE ID IN(");
  		for (int i = 0; i < id.length; i++) {
			sql.append(id[i]);
			sql.append(",");
		}
  		sql.deleteCharAt(sql.length()-1);
  		sql.append(")");

  		return executeUpdate(sql.toString());
  	}
 	/**
	 * @description:根据informId查询附件名称信息
	 * @author huangqiqing
	 * @param String id
	 * @return List<Map<String, Object>>
	 * @throws 无
	 * @since 2009-10-28
	 */
  	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryByInformId(String id){
  		String sql="SELECT FILENAME,ATTID  FROM APPROVALE_IN_INFORM_ATTACHMENT WHERE ID ='"+id+"'";
  		return executeQuery(sql);
  	}
  	/**
	 * @description:附件下载
	 * @author huangqiqing
	 * @param String id,String filename
	 * @return List<Map<String, Blob>>
	 * @throws 无
	 * @since 2009-10-28
	 */
  	@SuppressWarnings("unchecked")
	public List<Map<String, Blob>> download(String id,String filename){
  		String sql="SELECT FILECONTENT  FROM APPROVALE_IN_INFORM_ATTACHMENT WHERE ID ='"+id+"' AND FILENAME='"+filename+"'";
  		return executeQuery(sql);
  	}
}
