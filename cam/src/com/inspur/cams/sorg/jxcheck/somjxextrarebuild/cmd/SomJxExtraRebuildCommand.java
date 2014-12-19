package com.inspur.cams.sorg.jxcheck.somjxextrarebuild.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxextrarebuild.dao.*;

/**
 * @title:SomJxExtraRebuildCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxExtraRebuildCommand extends BaseAjaxCommand{
	private SomJxExtraRebuildDao dao = (SomJxExtraRebuildDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxextrarebuild.dao.SomJxExtraRebuildDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxExtraRebuild dataBean=(SomJxExtraRebuild)record.toBean(SomJxExtraRebuild.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxExtraRebuild dataBean=(SomJxExtraRebuild)record.toBean(SomJxExtraRebuild.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxExtraRebuild> list = new ArrayList<SomJxExtraRebuild>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxExtraRebuild dataBean = (SomJxExtraRebuild) records[i].toBean(SomJxExtraRebuild.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
