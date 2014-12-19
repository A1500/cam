package com.inspur.cams.bpt.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptPeopleDemobilizedDao;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;

/**
 * 在乡复员军人Domain
 * @author 王宝才
 */
public class BptPeopleDemobilizedDomain implements IBptPeopleDemobilizedDomain{
	@Reference
	private IBptPeopleDemobilizedDao  bptPeopleDemobilizedDao;
	
	/**
	 * 添加在乡复员军人Domain接口方法
	 * @param bptPeopleDemobilized
	 */
	public void insert(BptPeopleDemobilized bptPeopleDemobilized){
		List list =new ArrayList();
		list.add(bptPeopleDemobilized);
		bptPeopleDemobilizedDao.save(list);
	}
	
	/**
	 * 查询在乡复员军人信息（用于明细记录信息）
	 */
	public DataSet query(ParameterSet pset){
		return bptPeopleDemobilizedDao.query(pset);
	}
	
	/**
	 * 查询未提交的乡复员军人
	 */
	public DataSet queryUnCimDemPeo(ParameterSet pset){
		return bptPeopleDemobilizedDao.queryUnCimDemPeo(pset);
	}
    
	/**
	 * 更新在乡人员信息和相关优抚信息
	 */
	public void updateBptPeopleDemobilized(BptPeopleDemobilized bptPeopleDemobilized) {
		// TODO Auto-generated method stub
		bptPeopleDemobilizedDao.update(bptPeopleDemobilized);
	}
	public DataSet queryDemobilizedFlowHeader(String peopleId) {
		// TODO Auto-generated method stub
		
		return bptPeopleDemobilizedDao.queryDemobilizedFlowHeader(peopleId);
	}

	public String queryByProcessId(ParameterSet pset) {
		// TODO Auto-generated method stub
		String familId;
		String peopleId = (String) pset.getParameter("PEOPLE_ID");
		
		return familId = bptPeopleDemobilizedDao.queryByProcessId(peopleId);
	}
	/**
	 * 查询未提交的在乡复员换证军人
	 */
	public DataSet queryChangedemo(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleDemobilizedDao.queryChangedemo(pset);
	}
	/**
	 * 查询在乡复员换证军人IdCard
	 */
	public DataSet queryDemobilizedBptPeopleGetIdCard(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleDemobilizedDao.queryDemobilizedBptPeopleGetIdCard(pset);
	}
	
	public DataSet queryDemobilizedPeopleList(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleDemobilizedDao.queryDemobilizedPeopleList(pset);
	}
	public DataSet queryDemoEmigrationPeopleList(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleDemobilizedDao.queryDemoEmigrationPeopleList(pset);
	}
	public DataSet queryDemoProv(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleDemobilizedDao.queryDemoProv(pset);
	}

	public DataSet queryIllEmigrationPeopleList(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleDemobilizedDao.queryIllEmigrationPeopleList(pset);
	}
	/**
	 * 查询带病回乡军人IdCard
	 */
	public DataSet queryDemobilizedIllBptPeopleGetIdCard(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleDemobilizedDao.queryDemobilizedIllBptPeopleGetIdCard(pset);
	}

	public DataSet queryillprovinceEmigrationPeopleList(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleDemobilizedDao.queryillprovinceEmigrationPeopleList(pset);
	}
}