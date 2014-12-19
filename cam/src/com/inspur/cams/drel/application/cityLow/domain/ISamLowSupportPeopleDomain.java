package com.inspur.cams.drel.application.cityLow.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.application.cityLow.data.SamLowSupportPeople;

/**
 * 低收入家庭赡养、扶养、义务人情况domain
 * @author 
 * @date 2014-03-11
 */
public interface ISamLowSupportPeopleDomain {

	/**
	 * 查询 低收入家庭赡养、扶养、义务人情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 低收入家庭赡养、扶养、义务人情况
	 * @param pset
	 * @return
	 */
	public SamLowSupportPeople get(String supportId);

	/**
	 * 增加 低收入家庭赡养、扶养、义务人情况
	 * @param samLowSupportPeople
	 */
	@Trans
	public void insert(SamLowSupportPeople samLowSupportPeople);
	
	/**
	 * 修改 低收入家庭赡养、扶养、义务人情况
	 * @param samLowSupportPeople
	 */
	@Trans
	public void update(SamLowSupportPeople samLowSupportPeople);
	
	/**
	 * 删除 低收入家庭赡养、扶养、义务人情况
	 * @param supportId
	 */
	@Trans
	public void delete(String supportId);

}