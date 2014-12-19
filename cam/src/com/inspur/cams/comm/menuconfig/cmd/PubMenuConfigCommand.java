package com.inspur.cams.comm.menuconfig.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.menuconfig.dao.PubMenuConfigDao;
import com.inspur.cams.comm.menuconfig.data.PubMenuConfig;
import com.inspur.cams.comm.menuconfig.domain.IPubMenuConfigDomain;

/**
 * @title:PubMenuConfigCommand
 * @description:
 * @author:
 * @since:2011-08-09
 * @version:1.0
*/
public class PubMenuConfigCommand extends BaseAjaxCommand{
	private PubMenuConfigDao dao = (PubMenuConfigDao) DaoFactory
			.getDao("com.inspur.cams.comm.menuconfig.dao.PubMenuConfigDao");
	IPubMenuConfigDomain service = ScaComponentFactory.getService(IPubMenuConfigDomain.class,
	"pubMenuConfigDomain/pubMenuConfigDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		PubMenuConfig dataBean=(PubMenuConfig)record.toBean(PubMenuConfig.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		PubMenuConfig dataBean=(PubMenuConfig)record.toBean(PubMenuConfig.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<PubMenuConfig> list = new ArrayList<PubMenuConfig>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			PubMenuConfig dataBean = (PubMenuConfig) records[i].toBean(PubMenuConfig.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	
	public void applyMenuAll(){
		Record[] dsRecords = (Record[]) getParameter("dsRecords");
		String menuTypeId = (String) getParameter("menuTypeId");
		String menuTypeName =dao.getMenuTypeById(menuTypeId);
		service.applyMenuAll(dsRecords,menuTypeId,menuTypeName);
	}
}
