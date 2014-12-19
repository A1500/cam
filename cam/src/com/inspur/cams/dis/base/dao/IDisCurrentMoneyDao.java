package com.inspur.cams.dis.base.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.dis.base.data.DisCurrentMoney;

/**
 * 单位当前资金情况表dao
 * @author 
 * @date 2012-11-05
 */
public interface IDisCurrentMoneyDao extends BaseCURD<DisCurrentMoney> {

	void updateOfOrgan(String receiveOrganCode);

}