package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.base.dao.IDicHealthDao;
import com.inspur.cams.bpt.base.dao.jdbc.DicHealthDao;
import com.inspur.cams.bpt.base.data.DicHealth;

/**
 * @title:DicHealthQueryCommand
 * @description:
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
public class DicHealthQueryCommand extends BaseQueryCommand{

	
	
	public DataSet getAllWaraData() {
		ParameterSet pset = getParameterSet();
	
		IDicHealthDao dao = (IDicHealthDao) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.DicHealthDao");
		
		return dao.getAllWaraData();
		
	}
}
