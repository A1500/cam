package com.inspur.cams.bpt.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptPeopleTestedDao;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;

public class BptPeopleTestedDomain implements IBptPeopleTestedDomain{
    
	@Reference
	private IBptPeopleTestedDao bptPeopleTestedDao;
	
	public void insertTested(BptPeopleTested bptPeopleTested) {
		List list = new ArrayList ();
		list.add(bptPeopleTested);
		bptPeopleTestedDao.save(list);
		//bptPeopleTestedDao.insert(bptPeopleTested);
	}

	public DataSet queryTested(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleTestedDao.queryTested(pset);
	}
	
	public DataSet queryPeopleTested(ParameterSet pSet){
		return bptPeopleTestedDao.query(pSet);
	}
	
	public void updatePeopleTeseted(BptPeopleTested bptPeopleTested){
		 bptPeopleTestedDao.update(bptPeopleTested);
	}
	
	/**
	 * 查询未提交的参试人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUnCommitTest(ParameterSet pset) {
		return bptPeopleTestedDao.queryUnCommitTest(pset);
	}
	
	public void deleteWarTest(ParameterSet pset){
		bptPeopleTestedDao.deleteWarTest(pset);
	}
	
	public DataSet queryTongJiTested(ParameterSet pset){
		return bptPeopleTestedDao.queryTongJiTested(pset);
	}
}
