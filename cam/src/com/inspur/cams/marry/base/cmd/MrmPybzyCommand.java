package com.inspur.cams.marry.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.jdbc.MrmPybzyDao;
import com.inspur.cams.marry.base.data.MrmPybzy;

/**
 * @title:MrmPybzyCommand
 * @description:
 * @author:
 * @since:2012-02-13
 * @version:1.0
*/
public class MrmPybzyCommand extends BaseAjaxCommand{
	private MrmPybzyDao dao = (MrmPybzyDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmPybzyDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		MrmPybzy dataBean=(MrmPybzy)record.toBean(MrmPybzy.class);
		String pybzyId = IdHelp.getUUID32();
		dataBean.setPybzyId(pybzyId);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		MrmPybzy dataBean=(MrmPybzy)record.toBean(MrmPybzy.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<MrmPybzy> list = new ArrayList<MrmPybzy>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmPybzy dataBean = (MrmPybzy) records[i].toBean(MrmPybzy.class);
			String pybzyId = IdHelp.getUUID32();
			dataBean.setPybzyId(pybzyId);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
