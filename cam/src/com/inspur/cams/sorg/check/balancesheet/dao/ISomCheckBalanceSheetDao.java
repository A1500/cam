package com.inspur.cams.sorg.check.balancesheet.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet;

/**
 * @title:ISomCheckBalanceSheetDao
 * @description:
 * @author:
 * @since:2012-01-06
 * @version:1.0
*/
 public interface ISomCheckBalanceSheetDao extends BaseCURD<SomCheckBalanceSheet>{
	public void save(List<SomCheckBalanceSheet> list);
}

