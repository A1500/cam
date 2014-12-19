package com.inspur.cams.prs.prsattachment.dao;

import java.util.List;
import java.util.Map;

import org.loushang.next.dao.BaseCURD;

/**
 * @title:IPrsAttachmentDao
 * @description:
 * @author:
 * @since:2011-08-31
 * @version:1.0
*/
 public interface IPrsAttachmentDao extends BaseCURD<PrsAttachment>{
	public void save(List<PrsAttachment> list);
	
	public void batchDeleteByPoliciesId(String[] delIds);
	
	public List<Map<String,Object>> queryByPoliciesRegId(String policiesRegId);
	/**
	 * 附件下载
	 * @param id
	 * @param filename
	 * @return
	 */
	public List<Map<String,Object>> download(String id,String filename);
}

