package com.inspur.cams.comm.message.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.message.domain.IComMessageAttachmentDomain;


/**
 * 首页消息框上传附件表查询cmd
 * @author 
 * @date 2014-02-14
 */
public class ComMessageAttachmentQueryCmd extends BaseQueryCommand {

	private IComMessageAttachmentDomain comMessageAttachmentDomain = ScaComponentFactory
			.getService(IComMessageAttachmentDomain.class, "comMessageAttachmentDomain/comMessageAttachmentDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return comMessageAttachmentDomain.query(pset);
	}
	
}