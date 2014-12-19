package com.inspur.cams.drel.special.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.special.domain.ISpecialpoorHelpVillageDomain;

/**
 * 帮包村信息表查询cmd
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorHelpVillageQueryCmd extends BaseQueryCommand {

	private ISpecialpoorHelpVillageDomain specialpoorHelpVillageDomain = ScaComponentFactory
			.getService(ISpecialpoorHelpVillageDomain.class, "specialpoorHelpVillageDomain/specialpoorHelpVillageDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return specialpoorHelpVillageDomain.query(pset);
	}
	
}