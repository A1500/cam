package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomHeldPeopleDao;
import com.inspur.cams.sorg.base.data.SomHeldPeople;
import com.inspur.cams.sorg.base.domain.ISomHeldPeopleDomain;

/**
 * 社会组织发起人（自然人）domain实现类
 * @author shgtch
 * @date 2011年8月9日
 */
public class SomHeldPeopleDomain implements ISomHeldPeopleDomain {

	@Reference
	private ISomHeldPeopleDao somHeldPeopleDao;
	
	/**
	 * 查询发起人（自然人）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somHeldPeopleDao.queryHeldPeople(pset);
	}
	
	/**
	 * 增加发起人（自然人）
	 * @param dataBean
	 */
	public void insert(SomHeldPeople somHeldPeople) {
		somHeldPeopleDao.insert(somHeldPeople);
	}
	
	/**
	 * 更新发起人（自然人）
	 * @param dataBean
	 */
	public void update(SomHeldPeople somHeldPeople){
		somHeldPeopleDao.update(somHeldPeople);
	}

	/**
	 * 删除拟任负责人
	 * @param id
	 */
	public void delete(String id) {
		somHeldPeopleDao.delete(id);
	}
	
	/**
	 * 通过社会组织内码删除所有发起人（自然人）
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId) {
		somHeldPeopleDao.deleteBySorgId(sorgId);
	}
	
	/**
	 * 批量增加发起人（自然人）
	 * @param lists
	 */
	public void batchInsert(List<SomHeldPeople> lists) {
		somHeldPeopleDao.batchInsert(lists);
	}
	
	/**
	 * 批量更新发起人（自然人）
	 * @param lists
	 */
	public void batchUpdate(List<SomHeldPeople> lists) {
		somHeldPeopleDao.batchUpdate(lists);
	}
	
}
