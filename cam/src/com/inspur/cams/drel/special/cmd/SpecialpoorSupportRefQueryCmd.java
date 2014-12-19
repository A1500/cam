package com.inspur.cams.drel.special.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.special.domain.ISpecialpoorSupportRefDomain;

/**
 * 帮扶关系表查询cmd
 * 
 * @author
 * @date 2013-08-12
 */
public class SpecialpoorSupportRefQueryCmd extends BaseQueryCommand {

	private ISpecialpoorSupportRefDomain specialpoorSupportRefDomain = ScaComponentFactory
			.getService(ISpecialpoorSupportRefDomain.class,
					"specialpoorSupportRefDomain/specialpoorSupportRefDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return specialpoorSupportRefDomain.query(pset);
	}
	
	/**
	 * 查询帮扶单位与帮扶村的关系数据
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSupportRef() {
		ParameterSet pset = getParameterSet();
		return specialpoorSupportRefDomain.querySpecialpoorSupportRef(pset);
	}
	
	/**
	 * 查询帮扶单位指定的帮扶村数据
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorHelpVillage() {
		ParameterSet pset = getParameterSet();
		return specialpoorSupportRefDomain.querySpecialpoorHelpVillage(pset);
	}
}