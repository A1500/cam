package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.dao.jdbc.SomChangeDao;
import com.inspur.cams.sorg.base.domain.ISomChangeDomain;

/**
 * 社会组织基础信息查询CMD
 * @author yanliangliang
 * @date 2011-7-13
 */
public class SomChangeQueryCommand extends BaseQueryCommand{
	private ISomChangeDomain service = ScaComponentFactory.getService(ISomChangeDomain.class, "somChangeDomain/somChangeDomain");
	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomChangeDao> dao = (EntityDao<SomChangeDao>) DaoFactory
				.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomChangeDao");
		return dao.query(pset);
	}
	
	@SuppressWarnings("unchecked")
	public DataSet queryChangeInfo() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomChangeDao> dao = (EntityDao<SomChangeDao>) DaoFactory
		.getDao("com.inspur.cams.sorg.base.dao.jdbc.SomChangeDao");
		DataSet ds =service.queryChangeInfo(pset);
		return ds;
	}
}
