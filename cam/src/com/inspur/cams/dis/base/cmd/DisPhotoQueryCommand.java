package com.inspur.cams.dis.base.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.dis.base.data.DisPhoto;

/**
 * @title:DisPhotoQueryCommand
 * @description:
 * @author:
 * @since:2012-11-09
 * @version:1.0
*/
public class DisPhotoQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<DisPhoto> dao = (EntityDao<DisPhoto>) DaoFactory
				.getDao("com.inspur.cams.dis.base.dao.support.DisPhotoDao");
		return dao.query(pset);
	}
}
