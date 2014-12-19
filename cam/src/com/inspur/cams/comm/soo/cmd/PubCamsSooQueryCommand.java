package com.inspur.cams.comm.soo.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.soo.data.PubCamsSoo;

/**
 * @title:PubCamsSooQueryCommand
 * @description:
 * @author:
 * @since:2011-08-11
 * @version:1.0
*/
public class PubCamsSooQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<PubCamsSoo> dao = (EntityDao<PubCamsSoo>) DaoFactory
				.getDao("com.inspur.cams.comm.soo.dao.PubCamsSooDao");
		return dao.query(pset);
	}
	
}
