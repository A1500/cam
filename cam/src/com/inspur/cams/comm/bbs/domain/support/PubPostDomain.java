package com.inspur.cams.comm.bbs.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.bbs.dao.IPubPostDao;
import com.inspur.cams.comm.bbs.dao.IPubPostReplyDao;
import com.inspur.cams.comm.bbs.data.PubPost;
import com.inspur.cams.comm.bbs.data.PubPostReply;
import com.inspur.cams.comm.bbs.domain.IPubPostDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 帖子表domain
 * @author 
 * @date Thu Apr 25 01:05:26 GMT 2013
 */
public class PubPostDomain implements IPubPostDomain {

	@Reference
	private IPubPostDao pubPostDao;
	@Reference
	private IPubPostReplyDao pubPostReplyDao;

	/**
	 * 查询 帖子表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return pubPostDao.query(pset);
	}

	/**
	 * 获取 帖子表
	 * @param pset
	 * @return
	 */
	public PubPost get(String postId) {
		return pubPostDao.get(postId);
	}

	/**
	 * 增加 帖子表
	 * @param pubPost
	 */
	public void insert(PubPost pubPost) {
		pubPostDao.insert(pubPost);
	}
	
	/**
	 * 修改 帖子表
	 * @param pubPost
	 */
	public void update(PubPost pubPost) {
		pubPostDao.update(pubPost);
	}
	
	/**
	 * 删除 帖子表
	 * @param postId
	 */
	public void delete(String postId) {
		pubPostDao.delete(postId);
	}

	@SuppressWarnings("unchecked")
	public void deletePost(PubPost pubPost) {
			pubPostDao.update(pubPost);
			String postId =pubPost.getPostId();
			pubPostReplyDao.updateReplyByPostId(postId);
	}
	/**
	 * 保存 帖子表
	 * @param pubPost
	 */
	@SuppressWarnings("unchecked")
	public void save(PubPost pubPost,String id) {
		if(pubPost.getState()==Record.STATE_MODIFIED){
			pubPostDao.update(pubPost);
		}else if(pubPost.getState()==Record.STATE_DELETED){
			pubPostDao.delete(pubPost.getPostId());
		}else if(pubPost.getState()==Record.STATE_NEW){
			pubPost.setPostId(id);
			pubPost.setPostTime(DateUtil.getTime());
			pubPost.setBoardId("0000000022");//救灾
			pubPost.setReplyAmount("0");
			pubPost.setStatus("0");//0正常；1锁定；2删除
			pubPost.setIfTop("0");//0：否；1：是
			pubPostDao.insert(pubPost);
			
			//插入回复表
			PubPostReply PubPostReply=new PubPostReply();
			
			PubPostReply.setReplyId(IdHelp.getUUID32());
			PubPostReply.setPostId(pubPost.getPostId());
			PubPostReply.setReplyOrgancode(pubPost.getPostOrgancode());
			PubPostReply.setReplyOrganname(pubPost.getPostOrganname());
			PubPostReply.setReplyTime(pubPost.getPostTime());
			PubPostReply.setReplyContent(pubPost.getPostContent());
			PubPostReply.setStatus("0");//0正常；1锁定；2删除
			PubPostReply.setReplyNum("1");
			pubPostReplyDao.insert(PubPostReply);
		}
	}
}