package com.inspur.sdmz.jtxxszlx.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.sdmz.jtxxszlx.dao.*;
import com.inspur.sdmz.jtxx.dao.*;

/**
 * @title:YgjzJtxxSzlxCommand
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class YgjzJtxxSzlxCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
		"YgjzJtxxDomain/YgjzJtxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxDomain.queryYgjzJtxxSzlx(pset);
	}

	public void save() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
				"YgjzJtxxDomain/YgjzJtxxDomain");
		Record[] ygjzjtxxszlxRecords = (Record[]) getParameter("ygjzjtxxszlxRecords");
		List<YgjzJtxxSzlx> list = new ArrayList<YgjzJtxxSzlx>();
		for (int i = 0; i < ygjzjtxxszlxRecords.length; i++) {
			YgjzJtxxSzlx ygjzjtxxszlx = (YgjzJtxxSzlx)ygjzjtxxszlxRecords[i].toBean(YgjzJtxxSzlx.class);
			list.add(ygjzjtxxszlx);
		}
		ygjzjtxxDomain.saveYgjzJtxxSzlx(list);
	}
	public void delete() {
		EntityDao<YgjzJtxxSzlx> dao = (EntityDao<YgjzJtxxSzlx>) DaoFactory
		.getDao("com.inspur.sdmz.jtxxszlx.dao.YgjzJtxxSzlxDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}