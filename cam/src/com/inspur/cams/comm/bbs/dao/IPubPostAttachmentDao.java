package com.inspur.cams.comm.bbs.dao;

import java.util.List;
import java.util.Map;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.comm.bbs.data.PubPostAttachment;

/**
 * 帖子附件表dao
 * @author 
 * @date Fri Apr 26 08:57:51 GMT 2013
 */
public interface IPubPostAttachmentDao extends BaseCURD<PubPostAttachment> {

	public List<Map<String,Object>> queryAttachByPostId(String tztg);
}