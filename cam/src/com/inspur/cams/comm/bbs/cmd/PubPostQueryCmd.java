package com.inspur.cams.comm.bbs.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.bbs.domain.IPubPostDomain;

/**
 * 帖子表查询cmd
 * @author 
 * @date Thu Apr 25 01:05:26 GMT 2013
 */
public class PubPostQueryCmd extends BaseQueryCommand {

	private IPubPostDomain pubPostDomain = ScaComponentFactory
			.getService(IPubPostDomain.class, "pubPostDomain/pubPostDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return pubPostDomain.query(pset);
	}
	
}