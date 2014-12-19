package com.inspur.cams.bpt.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptPeopleWarDao;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.domain.IWarDomain;

public class WarDomain implements IWarDomain{
	@Reference
	private IBptPeopleWarDao bptPeopleWarDao;
	
	public DataSet query(ParameterSet pset) {
		return bptPeopleWarDao.query(pset);
	}

	public void insert(BptPeopleWar war) {
		List list = new ArrayList();
		list.add(war);
		bptPeopleWarDao.save(list);
		//bptPeopleWarDao.insert(war);
	}
	public DataSet queryWar(ParameterSet pset){
		return bptPeopleWarDao.queryWar(pset);
	}
	public void updateWar(BptPeopleWar war){
		
		bptPeopleWarDao.update(war);
	}
	//删除
	public void delete(ParameterSet pSet){
		bptPeopleWarDao.delete(pSet);
	}
	
	/**
	 * 查询未提交参战人员
	 * @param pSet
	 * @return
	 */
	public DataSet queryUnCommitWar(ParameterSet pset) {
		return bptPeopleWarDao.queryUnCommitWar(pset);
	}
}
