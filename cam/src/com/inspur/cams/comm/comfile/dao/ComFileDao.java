package com.inspur.cams.comm.comfile.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.dao.SqlCreator;
import org.loushang.persistent.jdbc.object.SqlUpdate;

import com.inspur.cams.comm.comfile.data.ComFile;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class ComFileDao extends EntityDao<ComFile> implements IComFileDao {

	private SqlUpdate photoInserter = null;
	public void initDao(){
		super.initDao();
		List insert = SqlCreator.getInsertSql(dbTable);
		String insertSql = (String)insert.get(0);
		insertSql = insertSql.replaceAll("COM_PHOTO", "COM_PHOTO_"+getFix() +"\n");
	    int[] insertTypes = (int[])insert.get(1);
	    if (this.photoInserter == null) {
	    	this.photoInserter = new SqlUpdate(getDataSource(), insertSql);
	    	this.photoInserter.setTypes(insertTypes);
	    	this.photoInserter.compile();
	    }
		
	}
	
	public ComFile insertPhoto(ComFile comFile) {
		comFile.setFileId(getFix()+IdHelp.getUUID30());
		photoInserter.update(SqlCreator.getInsertValues(this.dbTable, comFile));
	    return comFile;
	}
	
	private String getFix(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		return sdf.format(new Date());
		
		
	}
	
	protected Class getEntityClass() {
		return ComFile.class;
	}

}
