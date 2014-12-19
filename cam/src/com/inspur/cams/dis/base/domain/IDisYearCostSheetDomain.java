package com.inspur.cams.dis.base.domain;

import com.inspur.cams.dis.base.data.DisYearCostSheet;


public interface IDisYearCostSheetDomain {
	
	 public void save(DisYearCostSheet disYearCostSheet);
	 
	 public void update(DisYearCostSheet disYearCostSheet);
	 
	 public void delete(DisYearCostSheet disYearCostSheet);
	 
	 public void batchDelete(String[] delIds);
}
