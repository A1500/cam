package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmPeopleTransferManageDomain;

/**
 * 人员调动查询cmd
 * @author 
 * @date 2014-12-15
 */ 
public class JcmPeopleTransferManageQueryCmd extends BaseQueryCommand {

	private IJcmPeopleTransferManageDomain jcmPeopleTransferManageDomain = ScaComponentFactory
			.getService(IJcmPeopleTransferManageDomain.class, "jcmPeopleTransferManageDomain/jcmPeopleTransferManageDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmPeopleTransferManageDomain.query(pset);
	}
	
}