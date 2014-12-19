package com.inspur.cams.comm.bbs.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.bbs.data.PubPost;

/**
 * 帖子表domain
 * @author 
 * @date Thu Apr 25 01:05:26 GMT 2013
 */
public interface IPubPostDomain {

	/**
	 * 查询 帖子表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 帖子表
	 * @param pset
	 * @return
	 */
	public PubPost get(String postId);

	/**
	 * 增加 帖子表
	 * @param pubPost
	 */
	@Trans
	public void insert(PubPost pubPost);
	
	/**
	 * 修改 帖子表
	 * @param pubPost
	 */
	@Trans
	public void update(PubPost pubPost);
	
	/**
	 * 删除 帖子表
	 * @param postId
	 */
	@Trans
	public void delete(String postId);
	@Trans
	public void deletePost(PubPost pubPost);

	/**
	 * 保存 帖子表
	 * @param pubPost
	 */
	@Trans
	public void save(PubPost pubPost,String id);
}