package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.domain.IMrmElectronicDomain;

/**
 * 电子档案查询
 */
public class MrmElectronicQueryCmd extends BaseQueryCommand {
	// 获取SCA组件
	private IMrmElectronicDomain service = ScaComponentFactory.getService(
			IMrmElectronicDomain.class,
			"mrmElectronicDomain/mrmElectronicDomain");

	@SuppressWarnings("unchecked")
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}

	public DataSet queryCatalog() {
		ParameterSet pset = getParameterSet();
		return service.queryCatalogBySql(pset);
	}


	public DataSet queryElectronic() {
		ParameterSet pset = getParameterSet();
		return service.queryElectronic(pset);
	}


	/**
	 * 根据deptId查询社会组织的所有档案
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet queryElectronicByDeptId() {
		ParameterSet pset = getParameterSet();
		return service.queryElectronicByDeptId(pset);
	}
}
