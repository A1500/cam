package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmOfficeEquipmentDomain;

/**
 * 办公设备信息查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmOfficeEquipmentQueryCmd extends BaseQueryCommand {

	private IJcmOfficeEquipmentDomain jcmOfficeEquipmentDomain = ScaComponentFactory
			.getService(IJcmOfficeEquipmentDomain.class, "jcmOfficeEquipmentDomain/jcmOfficeEquipmentDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmOfficeEquipmentDomain.query(pset);
	}
	
	
	public DataSet queryEquipmentInfo() {
		ParameterSet pset = getParameterSet();
		return jcmOfficeEquipmentDomain.queryEquipmentInfo(pset);
	}
}