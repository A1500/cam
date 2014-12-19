package com.inspur.cams.comm.inform.privilege;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:InInformPrivilegeDao
 * @description:
 * @author:huangqiqing
 * @since:2009-10-28
 * @version:1.0
*/
 public class InformPrivilegeDao extends EntityDao<InformPrivilege> implements IInformPrivilegeDao{

 	public InformPrivilegeDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@SuppressWarnings("unchecked")
	@Override
	public Class getEntityClass() {
		return InformPrivilege.class;
	}
 	/**
	 * @description:删除通知接收人
	 * @author huangqiqing
	 * @param String id[]
	 * @return int ，影响的记录行数
	 * @throws 无
	 * @since 2009-10-28
	 */
  	public int batchDeleteInformPrivileges(String id[]){
  		StringBuffer sql=new StringBuffer();
  		sql.append("DELETE FROM APPROVALE_in_inform_privilege WHERE ID IN(");
  		for (int i = 0; i < id.length; i++) {
			sql.append(id[i]);

			//最后一个 id 后面不需要再加 “,”
			if(i==id.length-1){
				break;
			}
			sql.append(",");
		}
  		sql.append(")");

  		return executeUpdate(sql.toString());
  	}
 	/**
	 * @description:根据informId获取接收人（部门、用户）名称
	 * @author huangqiqing
	 * @param String id
	 * @return List<Map<String, Object>>
	 * @throws 无
	 * @since 2009-10-28
	 */
  	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryByInformId(String id){
  		List<Map<String, String>> list=executeQuery("SELECT RECEIVEMAN,RECEIVEMANTYPE  FROM APPROVALE_in_inform_privilege WHERE ID ='"+id+"'");
  		//如果接收部门下不存在用户，则直接返回null。
  		if(list.isEmpty()){
  			return null;
  		}
  		String sql="";
  		String receiveManType=list.get(0).get("RECEIVEMANTYPE");
  		//接收人如果是部门
  		if("organize".equals(receiveManType)){
  			String organId=list.get(0).get("RECEIVEMAN");;
  			if(organId.indexOf(",")>-1){
  				organId.replaceAll(",", "','");
  			}
			sql="select ORGAN_CODE RECEIVEMANID,SHORT_NAME RECEIVEMAN from PUB_ORGAN WHERE ORGAN_CODE IN ('"+organId+"')";
		}
  		return executeQuery(sql);
  	}
 	/**
	 * @description:查看是否已阅
	 * @author huangqiqing
	 * @param String informId,String userId,String organId
	 * @return 已阅返回true，未阅返回false
	 * @since 2009-11-11
	 */
  	@SuppressWarnings("unchecked")
	public boolean isResponsed(String informId,String userId,String organId){
  		StringBuffer sql=new StringBuffer();
  		sql.append("select FLAG from APPROVALE_IN_INFORM_PRIVILEGE ");
  		sql.append(getSql(informId, userId, organId));
  		String flag = "0";
  		List list = executeQuery(sql.toString());
  		if(list.size()>0){
  			Map map = (Map)list.get(0);
  			flag = (String)map.get("FLAG");
  		}
  		return "1".equals(flag);//1 表示已阅，0表示未阅
  	}
 	/**
	 * @description:将指定informId、userId、organId对应的通知状态置为”已阅“
	 * @author huangqiqing
	 * @param String informId,String userId,String organId
	 * @since 2009-11-11
	 */
  	public void changeToResponsed(String informId,String userId,String organId){
  		StringBuffer sql=new StringBuffer();
  		sql.append("update APPROVALE_IN_INFORM_PRIVILEGE set FLAG = '1' ");
  		sql.append(getSql(informId, userId, organId));
  		executeUpdate(sql.toString());
  	}
 	/**
	 * @description:收件人删除通知操作，将指定informId、userId、organId对应的记录删除
	 * @author huangqiqing
	 * @param String informId,String userId,String organId
	 * @since 2009-11-11
	 */
  	public void batchDeleteByInformIdAndUserId(String[] informId,String userId,String organId){
  		StringBuffer ids=new StringBuffer();
  		for (int i = 0; i < informId.length; i++) {
  			ids.append("'");
			ids.append(informId[i]);
			ids.append("',");
		}
  		if(ids.length()>0){
  			ids.deleteCharAt(ids.length()-1);
  		}
  		StringBuffer sql=new StringBuffer();
  		sql.append("delete from APPROVALE_IN_INFORM_PRIVILEGE ");
  		sql.append(" where ID in(").append(ids).append(")");
  		executeUpdate(sql.toString());
  	}
 	/**
	 * @description:提取公用代码块
	 * @author huangqiqing
	 * @param String informId,String userId,String organId
	 * @return String sql
	 * @throws 无
	 * @since 2009-11-11
	 */
  	public String getSql(String informId,String userId,String organId){
  		StringBuffer sql=new StringBuffer();
  		sql.append(" where ID='").append(informId).append("'");
  		sql.append(" and RECEIVEMANTYPE='organize'");
   		return sql.toString();
  	}
}
