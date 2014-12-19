package com.inspur.cams.sorg.jxcheck.somjxextrarebuildconcrete.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;

import com.inspur.cams.sorg.jxcheck.somjxextrarebuildconcrete.dao.SomJxExtraRebuildConcrete;
import com.inspur.cams.sorg.jxcheck.somjxextrarebuildconcrete.dao.SomJxExtraRebuildConcreteDao;

/**
 * @title:SomJxExtraRebuildConcreteCommand
 * @description:
 * @author:
 * @since:2012-01-16
 * @version:1.0
*/
public class SomJxExtraRebuildConcreteCommand extends BaseAjaxCommand{
	private SomJxExtraRebuildConcreteDao dao = (SomJxExtraRebuildConcreteDao) DaoFactory
			.getDao("org.somjxextrarebuildconcrete.dao.SomJxExtraRebuildConcreteDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxExtraRebuildConcrete dataBean=(SomJxExtraRebuildConcrete)record.toBean(SomJxExtraRebuildConcrete.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxExtraRebuildConcrete dataBean=(SomJxExtraRebuildConcrete)record.toBean(SomJxExtraRebuildConcrete.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxExtraRebuildConcrete> list = new ArrayList<SomJxExtraRebuildConcrete>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxExtraRebuildConcrete dataBean = (SomJxExtraRebuildConcrete) records[i].toBean(SomJxExtraRebuildConcrete.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
