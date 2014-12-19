package com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.dao.*;

/**
 * @title:SomJxCommonwealOutputCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCommonwealOutputCommand extends BaseAjaxCommand{
	private SomJxCommonwealOutputDao dao = (SomJxCommonwealOutputDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxcommonwealoutput.dao.SomJxCommonwealOutputDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCommonwealOutput dataBean=(SomJxCommonwealOutput)record.toBean(SomJxCommonwealOutput.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCommonwealOutput dataBean=(SomJxCommonwealOutput)record.toBean(SomJxCommonwealOutput.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCommonwealOutput> list = new ArrayList<SomJxCommonwealOutput>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCommonwealOutput dataBean = (SomJxCommonwealOutput) records[i].toBean(SomJxCommonwealOutput.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
