package com.inspur.cams.sorg.check.checkcashflow.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow;

/**
 * @title:现金流量表dao接口
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckCashFlowDao extends BaseCURD<SomCheckCashFlow>{
	public void save(List<SomCheckCashFlow> list);
}

