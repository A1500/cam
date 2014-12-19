package com.inspur.cams.comm.inform;


import java.util.List;
import java.util.Map;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;


/**
 * @title:InInformDao
 * @description:实现对通知的发布、撤销、删除、查询等操作
 * @author:tianbaoyun
 * @since:2009-10-27
 * @version:1.0
*/
 public class InformDao extends EntityDao<Inform> implements IInformDao{

 	public InformDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return Inform.class;
	}
	/**
	 * @description:撤销通知
	 * @author huangqiqing
	 * @param String id[]
	 * @return int ，影响的记录行数
	 * @since 2009-10-28
	 */
  	public int cancleInform(String id[]){
  		StringBuffer sql=new StringBuffer();
  		sql.append("UPDATE approvale_IN_INFORM SET FLAG='delete' WHERE ID IN(");
  		for (int i = 0; i < id.length; i++) {
			sql.append(id[i]);
			sql.append(",");
		}
  		if(sql.length()>0){
  			sql.deleteCharAt(sql.length()-1);
  		}
  		sql.append(")");
  		return executeUpdate(sql.toString());
  	}
	/**
	 * @description:根据userId和organId进行查询，返回收件人是userId或者收件人当前用户所在部门，并且状态是”有效“的记录。
	 * @author huangqiqing
	 * @param String organCode,String title,String sendman,int start,int limit
	 * @return List
	 * @since 2009-10-28
	 */
  	public DataSet queryReceiveBox(String title,String sendmanId,String isRead,int start,int limit){
  		StringBuffer sql=new StringBuffer();
  		sql.append("SELECT  A.ID ID,A.FLAG FLAG,B.FLAG BFLAG,A.INFORMTYPE,A.TITLE,A.SENDMAN,A.SENDMANID,A.SENDTIME,B.RECEIVEMAN ");
  		sql.append("FROM APPROVALE_IN_INFORM A,APPROVALE_IN_INFORM_PRIVILEGE B ");
  		sql.append("WHERE A.ID=B.ID ");
  		//sql.append(" AND  ROWNUM<=3");
  		//sql.append(" AND B.RECEIVEMAN='").append(organCode).append("'");
  	  	sql.append(" AND A.FLAG='ok'");
		sql.append(" AND B.RECEIVEMANTYPE='organize'");
  		if(!"".equals(title)){
  			sql.append(" AND A.TITLE LIKE '%").append(title).append("%'");
  		}
  		if(!"".equals(sendmanId)){
  			sql.append(" AND A.SENDMANID LIKE '%").append(sendmanId).append("%'");
  		}
//  		if(!"".equals(isRead)){
//  			sql.append(" AND B.FLAG LIKE '").append(isRead).append("'");
//  		}
  		sql.append(" ORDER BY A.SENDTIME DESC ,  B.FLAG ");
  		return executeDataset(sql.toString(), start, limit, false);
  	}
	/**
	 * @description:根据通知id进行查询，返回一条该通知id对应的记录。
	 * @author huangqiqing
	 * @param String informId
	 * @return List
	 * @since 2009-10-28
	 */
  	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> queryById(String informId){

  		String sql="SELECT A.TITLE,A.SENDMAN,A.CONTENT,A.SENDMANID,A.INFORMTYPE FROM APPROVALE_IN_INFORM A";
  		sql += " WHERE A.ID ='"+informId+"'";
  		return executeQuery(sql);
  	}


  	/**
	 * @description:根据通知id进行查询，返回一条该通知id对应的记录。
	 * @author huangqiqing
	 * @param String informId
	 * @return List
	 * @since 2009-10-28
	 */
  	@SuppressWarnings("unchecked")
	public DataSet queryByIds(String informIds,int start,int limit){

  		StringBuffer sql=new StringBuffer();
  		sql.append("SELECT  A.ID ID,A.FLAG FLAG,B.FLAG BFLAG,A.INFORMTYPE,A.TITLE,A.SENDMAN,A.SENDMANID,A.SENDTIME,B.RECEIVEMAN ");
  		sql.append("FROM APPROVALE_IN_INFORM A,APPROVALE_IN_INFORM_PRIVILEGE B ");
  		sql.append("WHERE A.ID=B.ID ");
  		sql.append(" AND  A.ID IN ("+informIds+")");
  		return executeDataset(sql.toString(),start, limit, false);
  	}

  	public DataSet querySendBox(String organCode,String title,String sendmanId,int start,int limit){
  		StringBuffer sql = new StringBuffer();
  		sql.append("SELECT A.ID,A.CONTENT,A.FLAG,A.INFORMTYPE,A.SENDMAN,A.SENDMANID,A.SENDTIME,A.TITLE,A.VALIDDAYNUM,B.RECEIVEMAN ");
  	    sql.append("FROM APPROVALE_IN_INFORM A,APPROVALE_IN_INFORM_PRIVILEGE B ");
  	  	sql.append("WHERE A.ID=B.ID ");
  	    sql.append(" AND A.SENDMAN='").append(organCode).append("'");
  	  	sql.append(" AND A.FLAG='ok'");
		sql.append(" AND B.RECEIVEMANTYPE='organize'");
  		if(!"".equals(title)){
  			sql.append(" AND A.TITLE LIKE '%").append(title).append("%'");
  		}
  		if(!"".equals(sendmanId)){
  			sql.append(" AND A.SENDMANID LIKE '%").append(sendmanId).append("%'");
  		}

  		sql.append(" ORDER BY A.SENDTIME , B.FLAG DESC");
		DataSet ds = this.executeDataset(sql.toString(), start, limit, true);
  		return ds;
  	}

}
