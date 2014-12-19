package com.inspur.cams.comm.soo.cmd;

import java.util.ArrayList;
import java.util.List;
import com.inspur.cams.comm.soo.data.PubCamsSoo;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.soo.dao.PubCamsSooDao;
import com.inspur.cams.comm.util.IdHelp;

/**
 * @title:PubCamsSooCommand
 * @description:
 * @author:
 * @since:2011-08-11
 * @version:1.0
*/
public class PubCamsSooCommand extends BaseAjaxCommand{
	private PubCamsSooDao dao = (PubCamsSooDao) DaoFactory
			.getDao("com.inspur.cams.comm.soo.dao.PubCamsSooDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		PubCamsSoo dataBean=(PubCamsSoo)record.toBean(PubCamsSoo.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		PubCamsSoo dataBean=(PubCamsSoo)record.toBean(PubCamsSoo.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		String userName = (String)getParameter("userName");
		List<PubCamsSoo> list = new ArrayList<PubCamsSoo>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			PubCamsSoo dataBean = (PubCamsSoo) records[i].toBean(PubCamsSoo.class);
			dataBean.setId(IdHelp.getUUID30());
			dataBean.setLocalUserName(userName);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
