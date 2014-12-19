package com.inspur.cams.comm.bbs.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.bbs.domain.IPubPostAttachmentDomain;

/**
 * 帖子附件表查询cmd
 * @author 
 * @date Fri Apr 26 08:57:51 GMT 2013
 */
public class PubPostAttachmentQueryCmd extends BaseQueryCommand {

	private IPubPostAttachmentDomain pubPostAttachmentDomain = ScaComponentFactory
			.getService(IPubPostAttachmentDomain.class, "pubPostAttachmentDomain/pubPostAttachmentDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return pubPostAttachmentDomain.query(pset);
	}
	
}