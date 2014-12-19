package com.inspur.cams.dis.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.dis.base.data.DisYearCostSheet;

/**
 * @title:IDisYearCostSheetDao
 * @description:
 * @author:
 * @since:2012-10-09
 * @version:1.0
*/
 public interface IDisYearCostSheetDao extends BaseCURD<DisYearCostSheet>{
	public void save(List<DisYearCostSheet> list);
}

