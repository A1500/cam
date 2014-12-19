package com.inspur.cams.comm.bbs.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.bbs.data.PubPostReply;
import com.inspur.cams.comm.bbs.domain.IPubPostReplyDomain;

/**
 * 帖子回复表cmd
 * @author 
 * @date Thu Apr 25 01:11:54 GMT 2013
 */
public class PubPostReplyCmd extends BaseAjaxCommand {

	private IPubPostReplyDomain pubPostReplyDomain = ScaComponentFactory
			.getService(IPubPostReplyDomain.class, "pubPostReplyDomain/pubPostReplyDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		PubPostReply pubPostReply = (PubPostReply) record.toBean(PubPostReply.class);
		pubPostReplyDomain.insert(pubPostReply);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		PubPostReply pubPostReply = (PubPostReply) record.toBean(PubPostReply.class);
		pubPostReplyDomain.update(pubPostReply);
	}
	
	// 删除
	public void delete() {
		String replyId = (String) getParameter("replyId");
		pubPostReplyDomain.delete(replyId);
	}
	
}