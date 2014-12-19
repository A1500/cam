package com.inspur.cams.drel.special.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.special.domain.ISpecialpoorSupportUnitDomain;

/**
 * 特殊困难帮扶单位信息表查询cmd
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorSupportUnitQueryCmd extends BaseQueryCommand {

	private ISpecialpoorSupportUnitDomain specialpoorSupportUnitDomain = ScaComponentFactory
			.getService(ISpecialpoorSupportUnitDomain.class, "specialpoorSupportUnitDomain/specialpoorSupportUnitDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return specialpoorSupportUnitDomain.query(pset);
	}
	
}