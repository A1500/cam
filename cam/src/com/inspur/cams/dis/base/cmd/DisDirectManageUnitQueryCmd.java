package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDisDirectManageUnitDomain;

/**
 * 直管单位配置表查询cmd
 * @author 
 * @date 2012-11-19
 */
public class DisDirectManageUnitQueryCmd extends BaseQueryCommand {

	private IDisDirectManageUnitDomain disDirectManageUnitDomain = ScaComponentFactory
			.getService(IDisDirectManageUnitDomain.class, "disDirectManageUnitDomain/disDirectManageUnitDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return disDirectManageUnitDomain.query(pset);
	}
	
	/**
	 * @Description: 查询指定单位下的所有直属单位
	 * @author xuexzh
	 */
	public DataSet queryAllUnit() {
		ParameterSet pset = getParameterSet();
		return disDirectManageUnitDomain.queryAllUnit(pset);
	}
	
	
}