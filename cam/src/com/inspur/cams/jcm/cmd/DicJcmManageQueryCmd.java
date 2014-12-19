package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IDicJcmManageDomain;

/**
 * 字典维护查询cmd
 * @author 
 * @date 2014-05-22
 */
public class DicJcmManageQueryCmd extends BaseQueryCommand {

	private IDicJcmManageDomain dicJcmManageDomain = ScaComponentFactory
			.getService(IDicJcmManageDomain.class, "dicJcmManageDomain/dicJcmManageDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicJcmManageDomain.query(pset);
	}
	
}