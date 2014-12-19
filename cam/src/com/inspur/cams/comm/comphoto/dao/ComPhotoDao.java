package com.inspur.cams.comm.comphoto.dao;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.dao.SqlCreator;
import org.loushang.persistent.jdbc.object.SqlUpdate;

import com.inspur.cams.comm.comphoto.data.ComPhoto;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class ComPhotoDao extends EntityDao<ComPhoto> implements IComPhotoDao{

	public void initDao(){
		super.initDao();
	}
	public ComPhoto insertPhoto(ComPhoto comPhoto) {
		SqlUpdate photoInserter = null;
		List insert = SqlCreator.getInsertSql(dbTable);
		String insertSql = (String)insert.get(0);
		insertSql = insertSql.replaceAll("COM_PHOTO", "COM_PHOTO_"+getFix() +"\n");
	    int[] insertTypes = (int[])insert.get(1);
	    if (photoInserter == null) {
	    	photoInserter = new SqlUpdate(getDataSource(), insertSql);
	    	photoInserter.setTypes(insertTypes);
	    	photoInserter.compile();
	    }
		comPhoto.setPhotoId(getFix()+IdHelp.getUUID30());
		photoInserter.update(SqlCreator.getInsertValues(this.dbTable, comPhoto));
	    return comPhoto;
	}
	
	private String getFix(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		return sdf.format(new Date());
		
		
	}
	
	protected Class getEntityClass() {
		return ComPhoto.class;
	}

}
