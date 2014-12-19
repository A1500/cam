package com.inspur.cams.sorg.jxcheck.somjxchecksendnote.cmd;

import java.util.*;
import org.loushang.next.dao.*;
import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import com.inspur.cams.sorg.jxcheck.somjxchecksendnote.dao.*;

/**
 * @title:SomJxCheckSendNoteCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckSendNoteCommand extends BaseAjaxCommand{
	private SomJxCheckSendNoteDao dao = (SomJxCheckSendNoteDao) DaoFactory
			.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksendnote.dao.SomJxCheckSendNoteDao");

	public void insert() {
		Record record = (Record) getParameter("record");
		SomJxCheckSendNote dataBean=(SomJxCheckSendNote)record.toBean(SomJxCheckSendNote.class);
		dao.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		SomJxCheckSendNote dataBean=(SomJxCheckSendNote)record.toBean(SomJxCheckSendNote.class);
		dao.update(dataBean);
	}

	public void delete() {
		String[] delIds=(String[]) getParameter("delIds");
		dao.batchDelete(delIds);
	}
	public void save() {
		// get the Record Array from UI
		Record[] records = (Record[]) getParameter("records");
		List<SomJxCheckSendNote> list = new ArrayList<SomJxCheckSendNote>();
		for (int i = 0; i < records.length; i++) {
			// convert record to entity bean
			SomJxCheckSendNote dataBean = (SomJxCheckSendNote) records[i].toBean(SomJxCheckSendNote.class);
			list.add(dataBean);
		}

		dao.save(list);
	}
}
