package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IComPhotoDomain;

/**
 * 人员照片表查询cmd
 * @author 
 * @date 2014-05-16
 */
public class ComPhotoQueryCmd extends BaseQueryCommand {

	private IComPhotoDomain comPhotoDomain = ScaComponentFactory
			.getService(IComPhotoDomain.class, "comPhotoDomain/comPhotoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return comPhotoDomain.query(pset);
	}
	
}