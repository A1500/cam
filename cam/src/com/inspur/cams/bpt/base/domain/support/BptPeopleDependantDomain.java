package com.inspur.cams.bpt.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptPeopleDependantDao;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;

/**
 * 遗属Domain
 * @author 王宝才
 */
public class BptPeopleDependantDomain implements IBptPeopleDependantDomain{
	@Reference
	private IBptPeopleDependantDao  bptPeopleDependantDao;
	
	/**
	 * 添加遗属信息
	 */
	public void insert(BptPeopleDependant bptPeopleDependant){
		List list =new ArrayList();
		list.add(bptPeopleDependant);
		bptPeopleDependantDao.save(list);
	}
	
	/**
	 * 更新类别三属信息
	 */
	public void update(BptPeopleDependant bptPeopleDependant){
		bptPeopleDependantDao.update(bptPeopleDependant);
	}
	
	/**
	 * 查询人员遗属信息
	 */
	public DataSet query(ParameterSet pset){
		return bptPeopleDependantDao.query(pset);
	}
	
	/**
	 * 查找人员、三属和优抚信息
	 */
	public DataSet queryDepePeo(ParameterSet pset){
		return bptPeopleDependantDao.queryDepePeo(pset);
	}
	
	/**
	 * 查询未提交的三属信息
	 * @param pset
	 * @return
	 */
	public DataSet queryUncommitDependant(ParameterSet pset) {
		return bptPeopleDependantDao.queryUncommitDependant(pset);
	}
	
	/**
	 * 查询三属人员申请审批表头信息
	 * @param peopleId
	 * @return
	 */
	public DataSet queryApplyHeader(String peopleId) {
		return bptPeopleDependantDao.queryApplyHeader(peopleId);
	}
}