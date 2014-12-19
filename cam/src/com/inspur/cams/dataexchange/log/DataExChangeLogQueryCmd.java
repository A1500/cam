package com.inspur.cams.dataexchange.log;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.dataexchange.log.DataExChangeLog;
import com.inspur.cams.dataexchange.log.IDataExChangeLogDao;
/**
 * @title: 数据交互查询CMD
 * @description:
 * @author: YLL
 * @since:2013-06-08
 * @version:1.0
*/
public class DataExChangeLogQueryCmd extends BaseQueryCommand{
	@Reference
	private IDataExChangeLogDao dataExChangeLogDao;
	
	
	public DataSet execute() {
		EntityDao<DataExChangeLog> dao = (EntityDao<DataExChangeLog>) DaoFactory
		.getDao("com.inspur.cams.dataexchange.log.DataExChangeLogDao");
		return dao.query(getParameterSet());
	}
	
	public DataSet queryReport() {
		EntityDao<DataExChangeLog> dao = (EntityDao<DataExChangeLog>) DaoFactory
		.getDao("com.inspur.cams.dataexchange.log.DataExChangeLogDao");
		return ((IDataExChangeLogDao) dao).queryReport(getParameterSet());
	}
}
