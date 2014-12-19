package com.inspur.cams.comm.inform.response;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

/**
 * @title:InformResponseQueryCommand
 * @description:执行相关查询操作
 * @author:tianbaoyun
 * @since:2009-11-11
 * @version:1.0
*/
public class InformResponseQueryCommand extends BaseQueryCommand{

	@SuppressWarnings("unchecked")
	public DataSet execute() {

		ParameterSet pset = getParameterSet();
		EntityDao<InformResponse> dao = (EntityDao<InformResponse>) DaoFactory.getDao("com.inspur.cams.inform.response.InformResponseDao");
		return dao.query(pset);
	}
}
