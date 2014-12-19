package com.inspur.cams.drel.application.cityLow.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.application.cityLow.data.SamLowApplyInfo;

/**
 * 低收入家庭认定业务表domain
 * @author 
 * @date 2014-03-11
 */
public interface ISamLowApplyInfoDomain {

	/**
	 * 查询 低收入家庭认定业务表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 低收入家庭认定业务表
	 * @param pset
	 * @return
	 */
	public SamLowApplyInfo get(String lowApplyId);

	/**
	 * 增加 低收入家庭认定业务表
	 * @param samLowApplyInfo
	 */
	@Trans
	public void insert(SamLowApplyInfo samLowApplyInfo);
	
	/**
	 * 修改 低收入家庭认定业务表
	 * @param samLowApplyInfo
	 */
	@Trans
	public void update(SamLowApplyInfo samLowApplyInfo);
	
	/**
	 * 删除 低收入家庭认定业务表
	 * @param lowApplyId
	 */
	@Trans
	public void delete(String lowApplyId);

}