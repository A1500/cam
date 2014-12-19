package com.inspur.cams.dis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.dis.base.domain.IDicDisMaterialTypeDomain;

/**
 * 救灾发放物资类型(字典)查询cmd
 * @author 
 * @date 2012-11-05
 */
public class DicDisMaterialTypeQueryCmd extends BaseQueryCommand {

	private IDicDisMaterialTypeDomain dicDisMaterialTypeDomain = ScaComponentFactory
			.getService(IDicDisMaterialTypeDomain.class, "dicDisMaterialTypeDomain/dicDisMaterialTypeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicDisMaterialTypeDomain.query(pset);
	}
	
}