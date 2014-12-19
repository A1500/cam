package com.inspur.cams.drel.sam.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleInsurance;

/**
 * @title:社会保险dao接口
 * @description:
 * @author:
 * @since:2012-05-03
 * @version:1.0
 */
public interface ISamPeopleInsuranceDao extends BaseCURD<SamPeopleInsurance> {
	/**
	 * 根据人员id删除社会保险
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId);
}
