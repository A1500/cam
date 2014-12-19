package com.inspur.cams.bpt.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.base.data.BptCertTemplates;

/**
 * @title:IBptCertTemplatesDao
 * @description:
 * @author:
 * @since:2011-11-22
 * @version:1.0
*/
 public interface IBptCertTemplatesDao extends BaseCURD<BptCertTemplates>{
	public void save(List<BptCertTemplates> list);
}

