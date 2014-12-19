package com.inspur.cams.comm.bbs.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.bbs.dao.IPubPostDao;
import com.inspur.cams.comm.bbs.dao.IPubPostReplyDao;
import com.inspur.cams.comm.bbs.data.PubPostReply;
import com.inspur.cams.comm.bbs.domain.IPubPostReplyDomain;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 帖子回复表domain
 * @author 
 * @date Thu Apr 25 01:11:54 GMT 2013
 */
public class PubPostReplyDomain implements IPubPostReplyDomain {

	@Reference
	private IPubPostReplyDao pubPostReplyDao;
	@Reference
	private IPubPostDao pubPostDao;
	/**
	 * 查询 帖子回复表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return pubPostReplyDao.query(pset);
	}

	/**
	 * 获取 帖子回复表
	 * @param pset
	 * @return
	 */
	public PubPostReply get(String replyId) {
		return pubPostReplyDao.get(replyId);
	}

	/**
	 * 增加 帖子回复表
	 * @param pubPostReply
	 */
	public void insert(PubPostReply pubPostReply) {
		pubPostReply.setReplyId(IdHelp.getUUID32());
		pubPostReply.setReplyTime(DateUtil.getTime());
		pubPostReply.setStatus("0");
		pubPostReplyDao.insert(pubPostReply);
		pubPostDao.updateNum(pubPostReply.getPostId());
	}
	
	/**
	 * 修改 帖子回复表
	 * @param pubPostReply
	 */
	public void update(PubPostReply pubPostReply) {
		pubPostReplyDao.update(pubPostReply);
	}
	
	/**
	 * 删除 帖子回复表
	 * @param replyId
	 */
	public void delete(String replyId) {
		pubPostReplyDao.delete(replyId);
	}

}