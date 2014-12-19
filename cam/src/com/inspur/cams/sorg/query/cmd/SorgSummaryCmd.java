package com.inspur.cams.sorg.query.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.query.dao.ISorgSummaryDao;

public class SorgSummaryCmd extends BaseQueryCommand {

	private ISorgSummaryDao service = ScaComponentFactory
			.getService(ISorgSummaryDao.class,"SorgSummaryDao/SorgSummaryDao");

	/**
	 * 决策分析——社会组织数量统计表
	 * 
	 * @return
	 */
	public DataSet querySorgNum() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.querySorgNum(pset);
		return ds;
	}
}
