package com.inspur.cams.comm.dicm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.dicm.domain.IDicManageDomain;


/***
 * 字典信息维护查询command
 * @author luguosui
 * @date 2011-8-31
 */
public class DicManageQueryCmd extends BaseQueryCommand{
	
	@Reference
	private IDicManageDomain dicManageDomain=ScaComponentFactory.getService(IDicManageDomain.class, "DicManageDomain/DicManageDomain");

	
	public DataSet execute(){
		ParameterSet pset = getParameterSet();
		return dicManageDomain.query(pset);
	}
}
