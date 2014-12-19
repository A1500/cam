package com.inspur.cams.sorg.assess.assessconfig.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.assess.assessconfig.dao.SomAssessConfigDao;
import com.inspur.cams.sorg.assess.assessconfig.data.SomAssessConfig;

/**
 * @title:SomAssessConfigCommand
 * @description:
 * @author:
 * @since:2011-12-03
 * @version:1.0
*/
public class SomAssessConfigCommand extends BaseAjaxCommand{
	private SomAssessConfigDao dao = (SomAssessConfigDao) DaoFactory
			.getDao("com.inspur.cams.sorg.assess.assessconfig.dao.SomAssessConfigDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		String configId = IdHelp.getUUID32();
		record.set("configId", configId);
		SomAssessConfig dataBean=(SomAssessConfig)record.toBean(SomAssessConfig.class);
		dao.insert(dataBean);
		this.setReturn("configId", configId);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomAssessConfig dataBean=(SomAssessConfig)record.toBean(SomAssessConfig.class);
		dao.update(dataBean);
	}

	public void delete() {
		String delId=(String) getParameter("delId");
		dao.delete(delId);
	}
	
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomAssessConfig> list = new ArrayList<SomAssessConfig>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomAssessConfig dataBean = (SomAssessConfig) records[i].toBean(SomAssessConfig.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
