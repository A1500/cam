package com.inspur.cams.comm.message.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.message.dao.IComMessageAttachmentDao;
import com.inspur.cams.comm.message.data.ComMessageAttachment;
import com.inspur.cams.comm.message.domain.IComMessageAttachmentDomain;


/**
 * 首页消息框上传附件表domain
 * @author 
 * @date 2014-02-14
 */
public class ComMessageAttachmentDomain implements IComMessageAttachmentDomain {

	@Reference
	private IComMessageAttachmentDao comMessageAttachmentDao;

	/**
	 * 查询 首页消息框上传附件表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return comMessageAttachmentDao.query(pset);
	}

	/**
	 * 获取 首页消息框上传附件表
	 * @param pset
	 * @return
	 */
	public ComMessageAttachment get(String attachmentId) {
		return comMessageAttachmentDao.get(attachmentId);
	}

	/**
	 * 增加 首页消息框上传附件表
	 * @param comMessageAttachment
	 */
	public void insert(ComMessageAttachment comMessageAttachment) {
		comMessageAttachmentDao.insert(comMessageAttachment);
	}
	
	/**
	 * 修改 首页消息框上传附件表
	 * @param comMessageAttachment
	 */
	public void update(ComMessageAttachment comMessageAttachment) {
		comMessageAttachmentDao.update(comMessageAttachment);
	}
	
	/**
	 * 删除 首页消息框上传附件表
	 * @param 
	 */
	public void delete(String attachmentId) {
		comMessageAttachmentDao.delete(attachmentId);
	}

}