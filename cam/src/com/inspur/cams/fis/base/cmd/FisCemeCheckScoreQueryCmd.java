package com.inspur.cams.fis.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.fis.base.domain.IFisCemeCheckScoreDomain;

/**
 * 公墓年检打分查询cmd
 * @author 
 * @date 2013-08-01
 */
public class FisCemeCheckScoreQueryCmd extends BaseQueryCommand {

	private IFisCemeCheckScoreDomain fisCemeCheckScoreDomain = ScaComponentFactory
			.getService(IFisCemeCheckScoreDomain.class, "fisCemeCheckScoreDomain/fisCemeCheckScoreDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return fisCemeCheckScoreDomain.query(pset);
	}
	public DataSet queryScore() {
		ParameterSet pset = getParameterSet();
		return fisCemeCheckScoreDomain.queryScore(pset);
	}
	
}