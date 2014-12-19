package com.inspur.cams.cdc.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.domain.ICdcSuperviseReviewInfoDomain;

/**
 * 基层民主民主监督信息表查询cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcSuperviseReviewInfoQueryCmd extends BaseQueryCommand {

	private ICdcSuperviseReviewInfoDomain cdcSuperviseReviewInfoDomain = ScaComponentFactory
			.getService(ICdcSuperviseReviewInfoDomain.class, "cdcSuperviseReviewInfoDomain/cdcSuperviseReviewInfoDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return cdcSuperviseReviewInfoDomain.query(pset);
	}
	
}