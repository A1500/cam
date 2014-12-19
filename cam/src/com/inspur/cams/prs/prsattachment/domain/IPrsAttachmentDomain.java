package com.inspur.cams.prs.prsattachment.domain;

import java.util.List;
import java.util.Map;

import org.loushang.sca.transaction.Trans;

import com.inspur.cams.prs.prsattachment.dao.PrsAttachment;

@Trans
public interface IPrsAttachmentDomain {
	/**
	 * 新增问题历史记录
	 */
	@Trans
	public void insert(PrsAttachment bean);
	/**
	 * 修改问题历史记录
	 */
	@Trans
	public void update(PrsAttachment bean);
	/**
	 * 查看问题历史记录
	 */
	@Trans
	public List<Map<String,Object>> queryByPoliciesId(String policiesId);
}
