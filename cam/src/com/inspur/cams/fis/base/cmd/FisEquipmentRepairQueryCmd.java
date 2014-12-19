package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisEquipmentRepairDomain;

/**
 * @Path com.inspur.cams.fis.base.cmd.FisEquipmentRepairQueryCmd  
 * @Description: TODO 殡葬业务维修记录表QueryCmd
 * @author wangziming
 * @date 2011-11-15
 */
public class FisEquipmentRepairQueryCmd extends BaseQueryCommand{
	
	IFisEquipmentRepairDomain service = ScaComponentFactory.getService(IFisEquipmentRepairDomain.class,
	"FisEquipmentRepairDomain/FisEquipmentRepairDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}
}