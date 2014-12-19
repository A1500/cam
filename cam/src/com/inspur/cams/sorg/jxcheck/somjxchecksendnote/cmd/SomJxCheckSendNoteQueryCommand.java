package com.inspur.cams.sorg.jxcheck.somjxchecksendnote.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.sorg.jxcheck.somjxchecksendnote.dao.*;

/**
 * @title:SomJxCheckSendNoteQueryCommand
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
public class SomJxCheckSendNoteQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<SomJxCheckSendNote> dao = (EntityDao<SomJxCheckSendNote>) DaoFactory
				.getDao("com.inspur.cams.sorg.jxcheck.somjxchecksendnote.dao.SomJxCheckSendNoteDao");
		return dao.query(pset);
	}
}
