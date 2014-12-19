package com.inspur.cams.comm.message.dao;

import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.comm.message.data.ComMessageAttachment;

/**
 * 首页消息框上传附件表dao
 * @author 
 * @date 2014-02-14
 */
public interface IComMessageAttachmentDao extends BaseCURD<ComMessageAttachment> {
	
	public void deleteByMessageId(String messageId);
}