package com.inspur.cams.comm.bbs.domain.support;

import java.util.List;
import java.util.Map;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.bbs.dao.IPubPostAttachmentDao;
import com.inspur.cams.comm.bbs.data.PubPostAttachment;
import com.inspur.cams.comm.bbs.domain.IPubPostAttachmentDomain;

/**
 * 帖子附件表domain
 * @author 
 * @date Fri Apr 26 08:57:51 GMT 2013
 */
public class PubPostAttachmentDomain implements IPubPostAttachmentDomain {

	@Reference
	private IPubPostAttachmentDao pubPostAttachmentDao;

	/**
	 * 查询 帖子附件表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return pubPostAttachmentDao.query(pset);
	}

	/**
	 * 获取 帖子附件表
	 * @param pset
	 * @return
	 */
	public PubPostAttachment get(String attachId) {
		return pubPostAttachmentDao.get(attachId);
	}

	/**
	 * 增加 帖子附件表
	 * @param pubPostAttachment
	 */
	public void insert(PubPostAttachment pubPostAttachment) {
		pubPostAttachmentDao.insert(pubPostAttachment);
	}
	
	/**
	 * 修改 帖子附件表
	 * @param pubPostAttachment
	 */
	public void update(PubPostAttachment pubPostAttachment) {
		pubPostAttachmentDao.update(pubPostAttachment);
	}
	
	/**
	 * 删除 帖子附件表
	 * @param attachId
	 */
	public void delete(String attachId) {
		pubPostAttachmentDao.delete(attachId);
	}

	public List<Map<String,Object>> queryAttachByPostId(String tztg) {
		return pubPostAttachmentDao.queryAttachByPostId(tztg);
	}
}