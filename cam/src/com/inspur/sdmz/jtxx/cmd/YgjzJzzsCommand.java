package com.inspur.sdmz.jtxx.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.sdmz.jtxx.data.SamIndex;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxDomain;

/**
 * @title:YgjzJzzsCommand
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class YgjzJzzsCommand extends BaseQueryCommand {

	public DataSet execute() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
		"YgjzJtxxDomain/YgjzJtxxDomain");
		ParameterSet pset = getParameterSet();
		return ygjzjtxxDomain.queryYgjzJzzs(pset);
	}

	public void save() {
		IYgjzJtxxDomain ygjzjtxxDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
				"YgjzJtxxDomain/YgjzJtxxDomain");
		Record[] ygjzjzzsRecords = (Record[]) getParameter("ygjzjzzsRecords");
		List<SamIndex> list = new ArrayList<SamIndex>();
		for (int i = 0; i < ygjzjzzsRecords.length; i++) {
			SamIndex ygjzjzzs = (SamIndex)ygjzjzzsRecords[i].toBean(SamIndex.class);
			list.add(ygjzjzzs);
		}
		ygjzjtxxDomain.saveYgjzJzzs(list);
	}
	public void delete() {
		EntityDao<SamIndex> dao = (EntityDao<SamIndex>) DaoFactory
		.getDao("com.inspur.sdmz.jzzs.dao.YgjzJzzsDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}