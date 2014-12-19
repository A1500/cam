package com.inspur.cams.bpt.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptCertTemplatesDao;
import com.inspur.cams.bpt.base.data.BptCertTemplates;
import com.inspur.cams.bpt.base.domain.IBptCertTemplatesDomain;

public class BptCertTemplatesDomain implements IBptCertTemplatesDomain {
	
	@Reference
	private IBptCertTemplatesDao bptCertTemplatesDao;
	
	
	/**
	 * 查询打证模板
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return bptCertTemplatesDao.query(pset);
	}
	
	/**
	 * 添加打证模板
	 * @param bptCertTemplates
	 */
	public void insert(BptCertTemplates bptCertTemplates) {
		bptCertTemplatesDao.insert(bptCertTemplates);
	}
	
	/**
	 * 修改打证模板
	 * @param bptCertTemplates
	 */
	public void update(BptCertTemplates bptCertTemplates) {
		bptCertTemplatesDao.update(bptCertTemplates);
	}
	
	/**
	 * 批量添加打证模板
	 * @param lists
	 */
	public void insert(List<BptCertTemplates> lists) {
		bptCertTemplatesDao.batchInsert(lists);
	}
	
	
}
