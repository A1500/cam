package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamPeopleIncome;

/**
 * @title:个人收入信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamPeopleIncomeDomain {
	/**
	 * 查询个人收入信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加个人收入信息
	 * @param samPeopleIncome
	 */
	@Trans
	public void insert(SamPeopleIncome samPeopleIncome);
	
	/**
	 * 更新个人收入信息
	 * @param samPeopleIncome
	 */
	@Trans
	public void update(SamPeopleIncome samPeopleIncome);
	
	/**
	 * 根据人员id删除个人收入信息
	 * @param peopleId
	 */
	@Trans
	public void deleteByPeopleId(String peopleId);
}
