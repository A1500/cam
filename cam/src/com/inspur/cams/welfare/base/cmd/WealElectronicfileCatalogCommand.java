package com.inspur.cams.welfare.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.welfare.base.dao.support.WealElectronicfileCatalogDao;
import com.inspur.cams.welfare.base.data.WealElectronicfileCatalog;

/**
 * WealElectronicfileCatalogCommand
 * @description:
 * @author:
 * @since:2013-04-19
 * @version:1.0
*/
public class WealElectronicfileCatalogCommand extends BaseAjaxCommand{
	private WealElectronicfileCatalogDao dao = (WealElectronicfileCatalogDao) DaoFactory
			.getDao("com.inspur.cams.welfare.base.dao.support.WealElectronicfileCatalogDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		WealElectronicfileCatalog dataBean=(WealElectronicfileCatalog)record.toBean(WealElectronicfileCatalog.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		WealElectronicfileCatalog dataBean=(WealElectronicfileCatalog)record.toBean(WealElectronicfileCatalog.class);
		dao.update(dataBean);
	}
	
	public void delete(){
		String[] delIds = (String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealElectronicfileCatalog> list = new ArrayList<WealElectronicfileCatalog>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealElectronicfileCatalog dataBean = (WealElectronicfileCatalog) records[i].toBean(WealElectronicfileCatalog.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
	public void saveOrUpdate() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<WealElectronicfileCatalog> list = new ArrayList<WealElectronicfileCatalog>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			WealElectronicfileCatalog dataBean = (WealElectronicfileCatalog) records[i].toBean(WealElectronicfileCatalog.class);
			
			if(!"".equals(dataBean.getCatalogId())){
				dao.update(dataBean);
			}else {
				dataBean.setCatalogId(IdHelp.getUUID32());
				list.add(dataBean);
			}
		}

		dao.save(list);
	}
}
