package com.inspur.cams.marry.base.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.jdbc.MrmFdyDao;
import com.inspur.cams.marry.base.data.MrmFdy;

/**
 * @title:MrmFdyCommand
 * @description:
 * @author:
 * @since:2012-02-02
 * @version:1.0
*/
public class MrmFdyCommand extends BaseAjaxCommand{
	private MrmFdyDao dao = (MrmFdyDao) DaoFactory
			.getDao("com.inspur.cams.marry.base.dao.jdbc.MrmFdyDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		MrmFdy dataBean=(MrmFdy)record.toBean(MrmFdy.class);
		String fdyId = IdHelp.getUUID32();
		dataBean.setFdyId(fdyId);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		MrmFdy dataBean=(MrmFdy)record.toBean(MrmFdy.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<MrmFdy> list = new ArrayList<MrmFdy>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			MrmFdy dataBean = (MrmFdy) records[i].toBean(MrmFdy.class);
			String fdyId = IdHelp.getUUID32();
			dataBean.setFdyId(fdyId);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
