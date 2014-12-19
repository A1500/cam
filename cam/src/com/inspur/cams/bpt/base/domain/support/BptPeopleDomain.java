package com.inspur.cams.bpt.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.bpt.base.dao.IBptPeopleDao;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;

/**
 * 添加优抚人员信息
 * @author 王宝才
 *
 */
public class BptPeopleDomain implements IBptPeopleDomain{
	
	@Reference
	private IBptPeopleDao bptPeopleDao;
	
	/**
	 * 添加优抚人员信息
	 */
	public void insert(BptPeople bptPeople) {
		bptPeopleDao.insert(bptPeople);
	}
	
	/**
	 * 更新优抚人员信息
	 */
	public void update(BptPeople bptPeople){
		bptPeopleDao.update(bptPeople);
	}
	
	/**
	 *  查询优抚人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset){
		return bptPeopleDao.query(pset);
	}
	/**
	 * 查询人员各种审批信息
	 * @return
	 */
	
	public DataSet queryApplyInfo(ParameterSet pset){
		return bptPeopleDao.queryApplyInfo(pset);
	}
	
	
	/**
	 * 查询优抚伤残减员人员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryDecreaseBpt(ParameterSet pset) {
		return bptPeopleDao.queryDecreaseBpt(pset);
	}
	
	/**
	 * 查询优抚增员信息
	 * @param pset
	 * @return
	 */
	public DataSet queryIncreaseBpt(ParameterSet pset) {
		return bptPeopleDao.queryIncreaseBpt(pset);
	}
	/**
	 * 查询人口数量
	 * @return
	 */
	public DataSet queryPeopleNumInfo(ParameterSet pset){
		return bptPeopleDao.queryPeopleNumInfo(pset);
	}
	/**
	 * 查询优抚对像申请信息列表
	 * @param pset
	 * @return
	 */
	public DataSet queryPeopleService(ParameterSet pset){
		return bptPeopleDao.queryPeopleService(pset);
	}
	
	public String  getMsgForNOPrint (ParameterSet pset){
		return bptPeopleDao.getMsgForNOPrint(pset);
	}
	
	/**
	 * 查询60岁服兵役年限人员信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet querySoldierYear(ParameterSet pset){
		return bptPeopleDao.querySoldierYear(pset);
	}
}