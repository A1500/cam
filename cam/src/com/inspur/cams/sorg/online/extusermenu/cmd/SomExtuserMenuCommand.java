package com.inspur.cams.sorg.online.extusermenu.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao;
import com.inspur.cams.sorg.online.extusermenu.data.SomExtuserMenu;

/**
 * @title:SomExtuserMenuCommand
 * @description:
 * @author:
 * @since:2012-11-01
 * @version:1.0
*/
public class SomExtuserMenuCommand extends BaseAjaxCommand{
	private SomExtuserMenuDao dao = (SomExtuserMenuDao) DaoFactory
			.getDao("com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomExtuserMenu dataBean=(SomExtuserMenu)record.toBean(SomExtuserMenu.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomExtuserMenu dataBean=(SomExtuserMenu)record.toBean(SomExtuserMenu.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomExtuserMenu> list = new ArrayList<SomExtuserMenu>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomExtuserMenu dataBean = (SomExtuserMenu) records[i].toBean(SomExtuserMenu.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
