package com.inspur.cams.comm.bbs.cmd;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.comm.bbs.data.PubPostAttachment;
import com.inspur.cams.comm.bbs.domain.IPubPostAttachmentDomain;
import com.inspur.cams.comm.bbs.util.PostCodec;

/**
 * 帖子附件表cmd
 * @author 
 * @date Fri Apr 26 08:57:51 GMT 2013
 */
public class PubPostAttachmentCmd extends BaseAjaxCommand {

	private IPubPostAttachmentDomain pubPostAttachmentDomain = ScaComponentFactory
			.getService(IPubPostAttachmentDomain.class, "pubPostAttachmentDomain/pubPostAttachmentDomain");
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		PubPostAttachment pubPostAttachment = (PubPostAttachment) record.toBean(PubPostAttachment.class);
		pubPostAttachmentDomain.insert(pubPostAttachment);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		PubPostAttachment pubPostAttachment = (PubPostAttachment) record.toBean(PubPostAttachment.class);
		pubPostAttachmentDomain.update(pubPostAttachment);
	}
	
	// 删除
	public void delete() {
		String attachId = (String) getParameter("attachId");
		pubPostAttachmentDomain.delete(attachId);
	}
	
	public void queryAttach(){
		String postId=(String)getParameter("postId");
		List<Map<String,Object>> list=pubPostAttachmentDomain.queryAttachByPostId(postId);
		StringBuffer filename = new StringBuffer();
		StringBuffer AttId = new StringBuffer();
		for (int i = 0; i < list.size(); i++) {
			filename.append(list.get(i).get("ATTACH_NAME"));// 转码前
			filename.append("~");// 分隔符
			filename.append(PostCodec.encode(list.get(i).get("ATTACH_NAME").toString()));// 转码后
			filename.append(",");
			//拿到附件的主键ID
			AttId.append(list.get(i).get("ATTACH_ID"));
			AttId.append(",");
		}
		if (filename.length() > 0) {
			filename.deleteCharAt(filename.length() - 1);// 去掉最后面的“,”
			AttId.deleteCharAt(AttId.length() - 1);
		}
		setReturn("filename", filename.toString());
		setReturn ("AttId",AttId.toString());
	}
}