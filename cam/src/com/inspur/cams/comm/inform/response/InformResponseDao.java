package com.inspur.cams.comm.inform.response;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:InInformResponseDao
 * @description:执行对回执信息的增加、删除操作
 * @author:tianbaoyun
 * @since:2009-11-11
 * @version:1.0
*/
 public class InformResponseDao extends EntityDao<InformResponse> implements IInInformResponseDao{

 	public InformResponseDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return InformResponse.class;
	}
  	/**
	 * @description:根据通知Id删除相关的回执信息
	 * @author huangqiqing
	 * @param String id[]
	 * @return int ，影响的记录行数
	 * @throws 无
	 * @since 2009-11-11
	 */
  	public int batchDeleteInformResponse(String id[]){
  		StringBuffer sql=new StringBuffer();
  		sql.append("DELETE FROM in_inform_response WHERE ID IN(");
  		for (int i = 0; i < id.length; i++) {
			sql.append(id[i]);
			sql.append(",");
		}
  		sql.deleteCharAt(sql.length()-1);
  		sql.append(")");

  		return executeUpdate(sql.toString());
  	}

}
