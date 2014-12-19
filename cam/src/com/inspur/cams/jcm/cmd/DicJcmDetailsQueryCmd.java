package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IDicJcmDetailsDomain;

/**
 * 字典详细信息查询cmd
 * @author 
 * @date 2014-05-22
 */
public class DicJcmDetailsQueryCmd extends BaseQueryCommand {

	private IDicJcmDetailsDomain dicJcmDetailsDomain = ScaComponentFactory
			.getService(IDicJcmDetailsDomain.class, "dicJcmDetailsDomain/dicJcmDetailsDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicJcmDetailsDomain.query(pset);
	}
	
}