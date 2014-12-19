package com.inspur.cams.comm.bbs.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.bbs.domain.IPubPostReplyDomain;

/**
 * 帖子回复表查询cmd
 * @author 
 * @date Thu Apr 25 01:11:54 GMT 2013
 */
public class PubPostReplyQueryCmd extends BaseQueryCommand {

	private IPubPostReplyDomain pubPostReplyDomain = ScaComponentFactory
			.getService(IPubPostReplyDomain.class, "pubPostReplyDomain/pubPostReplyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return pubPostReplyDomain.query(pset);
	}
	
}