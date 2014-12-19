package com.inspur.cams.bpt.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptCertTemplates;

/**
 * 优抚打证模板管理domain接口
 * @author zhanghui
 *
 */

public interface IBptCertTemplatesDomain {


	/**
	 * 查询打证模板
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 添加打证模板
	 * @param bptCertTemplates
	 */
	public void insert(BptCertTemplates bptCertTemplates);
	
	/**
	 * 修改打证模板
	 * @param bptCertTemplates
	 */
	public void update(BptCertTemplates bptCertTemplates);
	
	/**
	 * 批量添加打证模板
	 * @param lists
	 */
	public void insert(List<BptCertTemplates> lists);
}
