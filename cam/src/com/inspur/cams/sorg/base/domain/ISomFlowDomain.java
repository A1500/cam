package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomApply;
import com.inspur.cams.sorg.base.data.SomFlow;

/**
 * 社会组织业务流程意见domain接口
 * @author shgtch
 * @date 2011-8-12
 */
public interface ISomFlowDomain {

	/**
	 * 流程意见查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 保存流程意见
	 * @param dataBean
	 */
	@Trans
	public void insert(SomFlow somFlow);
	
	/**
	 * 根据业务获取流程历史意见并保持
	 * @param somApply
	 */
	@Trans
	public void insertBySomApply(SomApply somApply);
	/**
	 * 更新意见
	 * @param somFlow
	 */
	@Trans
	public void update(SomFlow somFlow);	
}
