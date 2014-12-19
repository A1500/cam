package com.inspur.cams.comm.message.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.message.data.ComMessageAttachment;


/**
 * 首页消息框上传附件表domain
 * @author 
 * @date 2014-02-14
 */
public interface IComMessageAttachmentDomain {

	/**
	 * 查询 首页消息框上传附件表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 首页消息框上传附件表
	 * @param pset
	 * @return
	 */
	public ComMessageAttachment get(String attachmentId);

	/**
	 * 增加 首页消息框上传附件表
	 * @param comMessageAttachment
	 */
	@Trans
	public void insert(ComMessageAttachment comMessageAttachment);
	
	/**
	 * 修改 首页消息框上传附件表
	 * @param comMessageAttachment
	 */
	@Trans
	public void update(ComMessageAttachment comMessageAttachment);
	
	/**
	 * 删除 首页消息框上传附件表
	 * @param 
	 */
	@Trans
	public void delete(String attachmentId);

}