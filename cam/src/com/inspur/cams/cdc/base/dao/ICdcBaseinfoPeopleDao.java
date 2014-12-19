package com.inspur.cams.cdc.base.dao;

import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.cdc.base.data.CdcBaseinfoPeople;

/**
 * 人员基础信息dao
 * @author 
 * @date 2012-05-25
 */
public interface ICdcBaseinfoPeopleDao extends BaseCURD<CdcBaseinfoPeople> {

	/**
	 * 删除家庭
	 * @param peopleId
	 */
	void deleteFamily(String peopleId);

}