package com.inspur.cams.sorg.jxcheck.somjxfee.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxfee.dao.*;

/**
 * @title:SomJxFeeCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxFeeCommand extends BaseAjaxCommand{
	private SomJxFeeDao dao = (SomJxFeeDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxfee.dao.SomJxFeeDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxFee dataBean=(SomJxFee)record.toBean(SomJxFee.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxFee dataBean=(SomJxFee)record.toBean(SomJxFee.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxFee> list = new ArrayList<SomJxFee>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxFee dataBean = (SomJxFee) records[i].toBean(SomJxFee.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
