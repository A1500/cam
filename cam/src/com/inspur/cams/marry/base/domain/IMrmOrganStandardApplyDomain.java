package com.inspur.cams.marry.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.marry.base.data.MrmOrganStandardApply;

/**
 * 婚姻登记机关等级评定标准业务表domain
 * @author 
 * @date 2012-11-28
 */
public interface IMrmOrganStandardApplyDomain {

	/**
	 * 查询 婚姻登记机关等级评定标准业务表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 查询，对result进行换行处理
	 * @param pset
	 * @return
	 */
	public DataSet queryApply(ParameterSet pset);

	/**
	 * 获取 婚姻登记机关等级评定标准业务表
	 * @param pset
	 * @return
	 */
	public MrmOrganStandardApply get(String applyId);

	/**
	 * 增加 婚姻登记机关等级评定标准业务表
	 * @param mrmOrganStandardApply
	 */
	@Trans
	public void insert(MrmOrganStandardApply mrmOrganStandardApply);
	
	/**
	 * 修改 婚姻登记机关等级评定标准业务表
	 * @param mrmOrganStandardApply
	 */
	@Trans
	public void update(MrmOrganStandardApply mrmOrganStandardApply);
	
	/**
	 * 删除 婚姻登记机关等级评定标准业务表
	 * @param applyId
	 */
	@Trans
	public void delete(String applyId);

}