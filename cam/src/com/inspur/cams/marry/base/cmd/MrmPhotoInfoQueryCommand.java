package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.domain.IMrmPhotoInfoDomain;

/**
 * @title:MrmPhotoInfoQueryCommand
 * @description:
 * @author:
 * @since:2012-03-14
 * @version:1.0
*/
public class MrmPhotoInfoQueryCommand extends BaseQueryCommand{
	private IMrmPhotoInfoDomain mrmPhotoInfoDomain = 
		ScaComponentFactory.getService(IMrmPhotoInfoDomain.class, "MrmPhotoInfoDomain/MrmPhotoInfoDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return mrmPhotoInfoDomain.query(pset);
	}
	
	public DataSet queryPhotoInfo(){
		ParameterSet pset = getParameterSet();
		return mrmPhotoInfoDomain.queryPhotoInfo(pset);
	}
}
