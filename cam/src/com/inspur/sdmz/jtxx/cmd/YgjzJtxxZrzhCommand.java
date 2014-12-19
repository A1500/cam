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

import com.inspur.sdmz.jtxx.data.SamFamilyCalamity;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxDomain;

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
		List<SamFamilyCalamity> list = new ArrayList<SamFamilyCalamity>();
		for (int i = 0; i < ygjzjtxxzrzhRecords.length; i++) {
			SamFamilyCalamity ygjzjtxxzrzh = (SamFamilyCalamity)ygjzjtxxzrzhRecords[i].toBean(SamFamilyCalamity.class);
			list.add(ygjzjtxxzrzh);
		}
		ygjzjtxxDomain.saveYgjzJtxxZrzh(list);
	}
	public void delete() {
		EntityDao<SamFamilyCalamity> dao = (EntityDao<SamFamilyCalamity>) DaoFactory
		.getDao("com.inspur.sdmz.jtxxzrzh.dao.YgjzJtxxZrzhDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}