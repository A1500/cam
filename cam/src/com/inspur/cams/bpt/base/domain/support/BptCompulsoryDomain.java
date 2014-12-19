package com.inspur.cams.bpt.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.dao.IBptCompulsoryDao;
import com.inspur.cams.bpt.base.data.BptCompulsory;
import com.inspur.cams.bpt.base.domain.IBptCompulsoryDomain;


public class BptCompulsoryDomain implements IBptCompulsoryDomain {

	private IBptCompulsoryDao bptCompulsoryDao;
	
	public void setBptCompulsoryDao(IBptCompulsoryDao bptCompulsoryDao) {
		this.bptCompulsoryDao = bptCompulsoryDao;
	}
	/**
 	* 厂家查询
 	*/

	public DataSet query(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptCompulsoryDao.query(pset);
	}
	/**
 	* 厂家维护
 	*/

	public void save(List<BptCompulsory> list) {
		// TODO Auto-generated method stub
		bptCompulsoryDao.save(list);
	}
	
	public DataSet queryCompulsory(ParameterSet pSet){
		return bptCompulsoryDao.queryCompulsory(pSet);
	}
}
