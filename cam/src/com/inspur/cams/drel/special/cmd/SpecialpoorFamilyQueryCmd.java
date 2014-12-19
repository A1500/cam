package com.inspur.cams.drel.special.cmd;

import org.loushang.sca.ScaComponentFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.special.domain.ISpecFamilyDomain;

/**
 * SpecialpoorFamilyQueryCmd
 * 
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
 */
public class SpecialpoorFamilyQueryCmd extends BaseQueryCommand {
	private ISpecFamilyDomain specFamilyDomain = ScaComponentFactory
			.getService(ISpecFamilyDomain.class,
					"specFamilyDomain/specFamilyDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return specFamilyDomain.query(pset);
	}

	/**
	 * @Description: 特殊困难户分致贫原因统计数
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSumByType() {
		ParameterSet pset = getParameterSet();
		return specFamilyDomain.querySpecialpoorSumByType(pset);
	}

	/**
	 * @Description: 特殊困难户分地区统计数
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSumByArea() {
		ParameterSet pset = getParameterSet();
		return specFamilyDomain.querySpecialpoorSumByArea(pset);
	}

	/**
	 * @Description: 特殊困难户省直单位统计
	 * @author yll
	 */
	public DataSet queryBySupport() {
		ParameterSet pset = getParameterSet();
		return specFamilyDomain.queryBySupport(pset);
	}
	
}
