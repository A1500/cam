package com.inspur.cams.comm.informUtil;

import org.loushang.next.data.DataSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

/**
 * @title:SourceSystemPeopleCommand
 * @description:
 * @author:
 * @since:2010-09-03
 * @version:1.0
*/
public class StruInfoQueryDa extends BaseJdbcDao{

	@Override
	protected void initDao() {
		// TODO Auto-generated method stub

	}

  	/**
  	 *
  	 *@description
  	 *@author 栗茜
  	 *@since 2011-3-1上午14:01:36
  	 *@param
  	 *@return  DataSet
  	 */
   public DataSet queryStruByOrganId(String organId){
	  String sql = "select t.* from pub_stru t where t.organ_id = '"+organId+"'";
	  return executeDataset(sql,true);
   }


}
