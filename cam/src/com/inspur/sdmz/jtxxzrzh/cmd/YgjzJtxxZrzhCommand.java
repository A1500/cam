package com.inspur.sdmz.jtxxzrzh.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;

import com.inspur.sdmz.jtxxzrzh.dao.*;
import com.inspur.sdmz.jtxx.dao.*;

/**
 * @title:YgjzJtxxZrzhCommand
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class YgjzJtxxZrzhCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
		"YgjzJtxxDomain/YgjzJtxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxDomain.queryYgjzJtxxZrzh(pset);
	}

	public void save() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
				"YgjzJtxxDomain/YgjzJtxxDomain");
		Record[] ygjzjtxxzrzhRecords = (Record[]) getParameter("ygjzjtxxzrzhRecords");
		List<YgjzJtxxZrzh> list = new ArrayList<YgjzJtxxZrzh>();
		for (int i = 0; i < ygjzjtxxzrzhRecords.length; i++) {
			YgjzJtxxZrzh ygjzjtxxzrzh = (YgjzJtxxZrzh)ygjzjtxxzrzhRecords[i].toBean(YgjzJtxxZrzh.class);
			list.add(ygjzjtxxzrzh);
		}
		ygjzjtxxDomain.saveYgjzJtxxZrzh(list);
	}
	public void delete() {
		EntityDao<YgjzJtxxZrzh> dao = (EntityDao<YgjzJtxxZrzh>) DaoFactory
		.getDao("com.inspur.sdmz.jtxxzrzh.dao.YgjzJtxxZrzhDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}