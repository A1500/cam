package com.inspur.cams.comm.comphoto.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.comphoto.dao.ComPhotoDao;
import com.inspur.cams.comm.comphoto.dao.IComPhotoDao;

public class ComPhotoQueryCmd extends BaseAjaxCommand{
	//private IComPhotoDomain comPhotoDomain = ScaComponentFactory.getService(ComPhotoDomain.class, "ComPhotoDomain/ComPhotoService");
	public DataSet execute(){
		ParameterSet parameterSet = getParameterSet();
		IComPhotoDao dao=(IComPhotoDao) DaoFactory.getDao(ComPhotoDao.class);
		return dao.query(parameterSet);
		
	}	

}
