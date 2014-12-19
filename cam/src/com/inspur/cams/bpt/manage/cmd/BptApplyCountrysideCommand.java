package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptApplyCountrysideDao;
import com.inspur.cams.bpt.base.data.BptApplyCountryside;

/**
 * @title:BptApplyCountrysideCommand
 * @description:
 * @author:
 * @since:2011-06-16
 * @version:1.0
*/
public class BptApplyCountrysideCommand extends BaseAjaxCommand{
	private BptApplyCountrysideDao dao = (BptApplyCountrysideDao) DaoFactory
			.getDao("org.bptapplycountryside.dao.BptApplyCountrysideDao");
	@Trans
	public void insert() {
		Record record = (Record) getParameter("record");
		BptApplyCountryside dataBean=(BptApplyCountryside)record.toBean(BptApplyCountryside.class);
		dao.insert(dataBean);
	}
	@Trans
	public void update() {
		Record record = (Record) getParameter("record");
		BptApplyCountryside dataBean=(BptApplyCountryside)record.toBean(BptApplyCountryside.class);
		dao.update(dataBean);
	}
	@Trans
	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	@Trans
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<BptApplyCountryside> list = new ArrayList<BptApplyCountryside>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			BptApplyCountryside dataBean = (BptApplyCountryside) records[i].toBean(BptApplyCountryside.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
