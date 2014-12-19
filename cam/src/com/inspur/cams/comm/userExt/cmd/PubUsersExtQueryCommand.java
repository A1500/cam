package com.inspur.cams.comm.userExt.cmd;

 

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.comm.userExt.data.PubUsersExt;

/**
 * @author licb
 * @date:2011-10-27 上午08:55:24
 * @version :
 * PubUsersExtQueryCommand.java 
 */
public class PubUsersExtQueryCommand extends BaseQueryCommand {
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<PubUsersExt> dao = (EntityDao<PubUsersExt>) DaoFactory
				.getDao("com.inspur.cams.comm.userExt.dao.PubUsersExtDao");
		DataSet ds = dao.query(pset);
		return ds;
	}

}
