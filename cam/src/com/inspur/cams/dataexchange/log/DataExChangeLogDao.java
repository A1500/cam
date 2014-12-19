package com.inspur.cams.dataexchange.log;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.Field;
import org.loushang.next.data.FieldSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.dataexchange.log.DataExChangeLog;
import com.inspur.cams.dataexchange.log.IDataExChangeLogDao;

/**
 * @title: 数据交互Dao
 * @description:
 * @author: YLL
 * @since:2013-06-05
 * @version:1.0
*/
 public class DataExChangeLogDao extends EntityDao<DataExChangeLog> implements IDataExChangeLogDao{

 	public DataExChangeLogDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return DataExChangeLog.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from DataExChangeLog");
	}
   /**
	 * @title 插入日志信息
	 * @param dataLog
	 * @param comExtUser
	 */
	public void insertLog(DataExChangeLog dataLog, ComExtUser comExtUser) {
		dataLog.setId(IdHelp.getUUID32());
		dataLog.setUnitCode(comExtUser.getOrganId());
		dataLog.setUnitName(comExtUser.getOrganName());
		dataLog.setUnitAccount(comExtUser.getUserId());
		dataLog.setQueryDate(DateUtil.getTime());
		insert(dataLog);
		
	}
	
	public DataSet queryReport(ParameterSet pset) {
		List<Object> typeList = new ArrayList<Object>();
		List<Object> argsList = new ArrayList<Object>();
		String startDate = (String)pset.getParameter("startDate");
		String endDate = (String)pset.getParameter("endDate");
		StringBuffer sql=new StringBuffer();
		sql.append("select  a.unit_name unitName, count(a.query_result_count) sumCount,");
		sql.append(" sum(case  when a.business_category='901'  then  1  else   0  end ) hunyinCount,  ");
		sql.append(" sum(case  when a.business_category='902'  then  1  else   0  end ) binzangCount  ");
		sql.append("   from DATA_EX_CHANGE_LOG a   ");
		boolean whereFlag =false;
		if(startDate!=null && !startDate.equals("") ){
			sql.append(" where  ");
			whereFlag = true;
			sql.append(" query_date >= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(startDate);
		}
		if(endDate!=null && !endDate.equals("")){
			if(!whereFlag){
				sql.append(" where  ");
			}else{
				sql.append(" and  ");
			}
			sql.append(" query_date <= ?");
			typeList.add(Types.VARCHAR);
			argsList.add(endDate);
		}
		sql.append("  group by a.unit_name  ");
		sql.append("  order by count(a.query_result_count)  ");
		
		//关联查询党员变动
		
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = (Integer) (typeList.get(i));
		}
		Object[] args = argsList.toArray(new Object[argsList.size()]);
		DataSet ds=executeDataset(sql.toString(), types, args,  true);
		return ds;
	}
   
}
