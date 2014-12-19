package com.inspur.cams.dataexchange.log;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.extuser.data.ComExtUser;

/**
 * @title: 数据交互Dao
 * @description:
 * @author: YLL
 * @since:2013-06-05
 * @version:1.0
*/
 public interface IDataExChangeLogDao extends BaseCURD<DataExChangeLog>{
	public void save(List<DataExChangeLog> list);
	/**
	 * 插入日志信息
	 * @param dataLog
	 * @param comExtUser
	 */
	public void insertLog(DataExChangeLog dataLog, ComExtUser comExtUser);
	
	public DataSet queryReport(ParameterSet pset) ;
}

