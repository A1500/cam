package com.inspur.cams.comm.bbs.domain;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.bbs.data.PubPostAttachment;

/**
 * 帖子附件表domain
 * @author 
 * @date Fri Apr 26 08:57:51 GMT 2013
 */
public interface IPubPostAttachmentDomain {

	/**
	 * 查询 帖子附件表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 帖子附件表
	 * @param pset
	 * @return
	 */
	public PubPostAttachment get(String attachId);

	/**
	 * 增加 帖子附件表
	 * @param pubPostAttachment
	 */
	@Trans
	public void insert(PubPostAttachment pubPostAttachment);
	
	/**
	 * 修改 帖子附件表
	 * @param pubPostAttachment
	 */
	@Trans
	public void update(PubPostAttachment pubPostAttachment);
	
	/**
	 * 删除 帖子附件表
	 * @param attachId
	 */
	@Trans
	public void delete(String attachId);
	@Trans
	public List<Map<String,Object>>  queryAttachByPostId(String tztg);

}