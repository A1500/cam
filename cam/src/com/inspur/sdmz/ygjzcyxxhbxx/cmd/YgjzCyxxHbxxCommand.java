package com.inspur.sdmz.ygjzcyxxhbxx.cmd;


import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.sdmz.jtxxcyxx.domain.IYgjzJtxxCyxxDomain;
import com.inspur.sdmz.ygjzcyxxhbxx.dao.YgjzCyxxHbxx;
 

/**
 * @title:YgjzCyxxHbxxCommand
 * @description:
 * @author:
 * @since:2011-04-25
 * @version:1.0
*/
public class YgjzCyxxHbxxCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
		"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxcyxxDomain.queryYgjzCyxxHbxx(pset);
	}

	public void save() {
		IYgjzJtxxCyxxDomain ygjzjtxxcyxxDomain = ScaComponentFactory.getService(IYgjzJtxxCyxxDomain.class,
				"YgjzJtxxCyxxDomain/YgjzJtxxCyxxDomain");
		Record[] ygjzcyxxhbxxRecords = (Record[]) getParameter("ygjzcyxxhbxxRecords");
		List<YgjzCyxxHbxx> list = new ArrayList<YgjzCyxxHbxx>();
		for (int i = 0; i < ygjzcyxxhbxxRecords.length; i++) {
			YgjzCyxxHbxx ygjzcyxxhbxx = (YgjzCyxxHbxx)ygjzcyxxhbxxRecords[i].toBean(YgjzCyxxHbxx.class);
			list.add(ygjzcyxxhbxx);
		}
		ygjzjtxxcyxxDomain.saveYgjzCyxxHbxx(list);
	}
	public void delete() {
		EntityDao<YgjzCyxxHbxx> dao = (EntityDao<YgjzCyxxHbxx>) DaoFactory
		.getDao("org.ygjzcyxxhbxx.dao.YgjzCyxxHbxxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}