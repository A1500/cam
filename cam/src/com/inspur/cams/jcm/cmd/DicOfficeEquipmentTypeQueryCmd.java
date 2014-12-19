package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IDicOfficeEquipmentTypeDomain;

/**
 * 办公设备类别查询cmd
 * @author 
 * @date 2014-05-21
 */
public class DicOfficeEquipmentTypeQueryCmd extends BaseQueryCommand {

	private IDicOfficeEquipmentTypeDomain dicOfficeEquipmentTypeDomain = ScaComponentFactory
			.getService(IDicOfficeEquipmentTypeDomain.class, "dicOfficeEquipmentTypeDomain/dicOfficeEquipmentTypeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicOfficeEquipmentTypeDomain.query(pset);
	}
	
}