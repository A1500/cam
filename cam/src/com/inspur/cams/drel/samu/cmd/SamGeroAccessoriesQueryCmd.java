package com.inspur.cams.drel.samu.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.samu.domain.ISamGeroAccessoriesDomain;

/**
 * 敬老院附件信息表查询cmd
 * @author 
 * @date 2012-10-24
 */
public class SamGeroAccessoriesQueryCmd extends BaseQueryCommand {

	private ISamGeroAccessoriesDomain samGeroAccessoriesDomain = ScaComponentFactory
			.getService(ISamGeroAccessoriesDomain.class, "samGeroAccessoriesDomain/samGeroAccessoriesDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return samGeroAccessoriesDomain.query(pset);
	}
	
}