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

import com.inspur.sdmz.jtxx.data.SamFamilyAssistance;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxDomain;


/**
 * @title:SamFamilyAssistanceCmd救助基本信息
 * @description:
 * @author:
 * @since:2011-04-18
 * @version:1.0
*/
public class SamFamilyAssistanceCmd extends BaseQueryCommand {
	IYgjzJtxxDomain baseinfoFamilyDomain = ScaComponentFactory.getService(IYgjzJtxxDomain.class,
	"YgjzJtxxDomain/YgjzJtxxDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return baseinfoFamilyDomain.querySamFamilyAssistance(pset);
	}

	public void save() {
		Record[] ygjzjtxxszlxRecords = (Record[]) getParameter("ygjzjtxxszlxRecords");
		List<SamFamilyAssistance> list = new ArrayList<SamFamilyAssistance>();
		for (int i = 0; i < ygjzjtxxszlxRecords.length; i++) {
			SamFamilyAssistance ygjzjtxxszlx = (SamFamilyAssistance)ygjzjtxxszlxRecords[i].toBean(SamFamilyAssistance.class);
			list.add(ygjzjtxxszlx);
		}
		baseinfoFamilyDomain.saveSamFamilyAssistance(list);
	}
	public void delete() {
		EntityDao<SamFamilyAssistance> dao = (EntityDao<SamFamilyAssistance>) DaoFactory
		.getDao("com.inspur.sdmz.jtxx.dao.jdbc.SamFamilyAssistanceDao");
		String delId = (String) getParameter("delId");
		dao.delete(delId);
	}
}