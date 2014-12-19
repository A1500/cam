package com.inspur.cams.comm.message.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.message.data.ComMessageAttachment;
import com.inspur.cams.comm.message.domain.IComMessageAttachmentDomain;

/**
 * 首页消息框上传附件表cmd
 * @author 
 * @date 2014-02-14
 */
public class ComMessageAttachmentCmd extends BaseAjaxCommand {

	private IComMessageAttachmentDomain comMessageAttachmentDomain = ScaComponentFactory
			.getService(IComMessageAttachmentDomain.class, "comMessageAttachmentDomain/comMessageAttachmentDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		ComMessageAttachment comMessageAttachment = (ComMessageAttachment) record.toBean(ComMessageAttachment.class);
		comMessageAttachmentDomain.insert(comMessageAttachment);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		ComMessageAttachment comMessageAttachment = (ComMessageAttachment) record.toBean(ComMessageAttachment.class);
		comMessageAttachmentDomain.update(comMessageAttachment);
	}
	
	// 删除
	public void delete() {
		String attachmentId = (String) getParameter("attachmentId");
		comMessageAttachmentDomain.delete(attachmentId);
	}
	
}