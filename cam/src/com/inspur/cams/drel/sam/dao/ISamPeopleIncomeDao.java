package com.inspur.cams.drel.sam.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleIncome;

/**
 * @title:人员收入信息dao接口
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
public interface ISamPeopleIncomeDao extends BaseCURD<SamPeopleIncome> {
	/**
	 * 根据人员id删除个人收入信息
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId);
}
