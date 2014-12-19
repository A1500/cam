package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomHeldOrganDao;
import com.inspur.cams.sorg.base.data.SomHeldOrgan;
import com.inspur.cams.sorg.base.domain.ISomHeldOrganDomain;

/**
 * 社会组织发起人（单位）domain实现类
 * @author shgtch
 * @date 2011年8月9日
 */
public class SomHeldOrganDomain implements ISomHeldOrganDomain {

	@Reference
	private ISomHeldOrganDao somHeldOrganDao;
	
	/**
	 * 查询发起人（单位）
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somHeldOrganDao.queryHeldOrgan(pset);
	}
	
	/**
	 * 增加发起人（单位）
	 * @param dataBean
	 */
	public void insert(SomHeldOrgan somHeldOrgan) {
		somHeldOrganDao.insert(somHeldOrgan);
	}
	
	/**
	 * 更新发起人（单位）
	 * @param dataBean
	 */
	public void update(SomHeldOrgan somHeldOrgan){
		somHeldOrganDao.update(somHeldOrgan);
	}

	/**
	 * 删除拟任负责人
	 * @param id
	 */
	public void delete(String id) {
		somHeldOrganDao.delete(id);
	}
	
	/**
	 * 通过社会组织内码删除所有发起人（单位）
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId) {
		somHeldOrganDao.deleteBySorgId(sorgId);
	}
	
	/**
	 * 批量增加发起人（单位）
	 * @param lists
	 */
	public void batchInsert(List<SomHeldOrgan> lists) {
		somHeldOrganDao.batchInsert(lists);
	}
	
	/**
	 * 批量更新发起人（单位）
	 * @param lists
	 */
	public void batchUpdate(List<SomHeldOrgan> lists) {
		somHeldOrganDao.batchUpdate(lists);
	}
	
}
