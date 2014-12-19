package com.inspur.cams.sorg.jxcheck.somjxchecksendnote.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckSendNoteDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckSendNoteDao extends BaseCURD<SomJxCheckSendNote>{
	public void save(List<SomJxCheckSendNote> list);
}

