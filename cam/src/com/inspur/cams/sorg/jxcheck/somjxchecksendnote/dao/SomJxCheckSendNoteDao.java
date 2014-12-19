package com.inspur.cams.sorg.jxcheck.somjxchecksendnote.dao;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;

/**
 * @title:SomJxCheckSendNoteDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public class SomJxCheckSendNoteDao extends EntityDao<SomJxCheckSendNote> implements ISomJxCheckSendNoteDao{

 	public SomJxCheckSendNoteDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory
					.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}

  	@Override
	public Class getEntityClass() {
		return SomJxCheckSendNote.class;
	}
   public void deleteStruAll() {
		executeUpdate("delete from SomJxCheckSendNote");
	}
   
}
