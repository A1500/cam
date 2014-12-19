package com.inspur.cams.welfare.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.welfare.base.dao.support.WealElectronicfileContentDao;
import com.inspur.cams.welfare.base.data.WealElectronicfileContent;

/**
 * WealElectronicfileContentQueryCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealElectronicfileContentQueryCommand extends BaseQueryCommand{
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<WealElectronicfileContent> dao = (EntityDao<WealElectronicfileContent>) DaoFactory
				.getDao("com.inspur.cams.welfare.base.dao.support.WealElectronicfileContentDao");
		return dao.query(pset);
	}
	
	
	
	WealElectronicfileContentDao queryDao = (WealElectronicfileContentDao) DaoFactory
	.getDao("com.inspur.cams.welfare.base.dao.support.WealElectronicfileContentDao");
	/*
	 * 查询电子档案目录
	 * */
	public DataSet queryElectronicfileCatalog(){
		ParameterSet pset = getParameterSet();
		return queryDao.queryElectronicfileCatalogBySql(pset);
	}
	/*
	 * 下载时的电子档案目录
	 * */
	public DataSet queryCatalog(){
		ParameterSet pset = getParameterSet();
		return queryDao.queryCatalog(pset);
		
	}
}
