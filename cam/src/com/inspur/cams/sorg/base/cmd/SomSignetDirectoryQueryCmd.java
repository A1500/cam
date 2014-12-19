package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomSignetDirectoryDomain;

/**
 * 印章名录查询
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomSignetDirectoryQueryCmd extends BaseQueryCommand {

	private ISomSignetDirectoryDomain somSignetDirectoryDomain = ScaComponentFactory
			.getService(ISomSignetDirectoryDomain.class,
					"somSignetDirectoryDomain/somSignetDirectoryDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somSignetDirectoryDomain.query(pset);
	}
}
