package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IDicCemeAccessoriesTypeDomain;

/**
 * 公墓年检附件类型字典查询cmd
 * @author 
 * @date 2013-08-01
 */
public class DicCemeAccessoriesTypeQueryCmd extends BaseQueryCommand {

	private IDicCemeAccessoriesTypeDomain dicCemeAccessoriesTypeDomain = ScaComponentFactory
			.getService(IDicCemeAccessoriesTypeDomain.class, "dicCemeAccessoriesTypeDomain/dicCemeAccessoriesTypeDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return dicCemeAccessoriesTypeDomain.query(pset);
	}
	
}