package com.inspur.cams.comm.bbs.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.bbs.data.PubPostReply;

/**
 * 帖子回复表domain
 * @author 
 * @date Thu Apr 25 01:11:54 GMT 2013
 */
public interface IPubPostReplyDomain {

	/**
	 * 查询 帖子回复表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 帖子回复表
	 * @param pset
	 * @return
	 */
	public PubPostReply get(String replyId);

	/**
	 * 增加 帖子回复表
	 * @param pubPostReply
	 */
	@Trans
	public void insert(PubPostReply pubPostReply);
	
	/**
	 * 修改 帖子回复表
	 * @param pubPostReply
	 */
	@Trans
	public void update(PubPostReply pubPostReply);
	
	/**
	 * 删除 帖子回复表
	 * @param replyId
	 */
	@Trans
	public void delete(String replyId);

}