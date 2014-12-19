package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomAspchiefDao;
import com.inspur.cams.sorg.base.data.SomAspchief;
import com.inspur.cams.sorg.base.domain.ISomAspchiefDomain;

/**
 * 社会组织拟任负责人domain实现类
 * @author shgtch
 * @date 2011年8月9日
 */
public class SomAspchiefDomain implements ISomAspchiefDomain {

	@Reference
	private ISomAspchiefDao somAspchiefDao;
	
	/**
	 * 查询社会组织拟任负责人
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somAspchiefDao.queryNoPage(pset);
	}
	
	/**
	 * 增加社会组织拟任负责人
	 * @param dataBean
	 */
	public void insert(SomAspchief somAspchief) {
		somAspchiefDao.insert(somAspchief);
	}
	
	/**
	 * 更新社会组织拟任负责人
	 * @param dataBean
	 */
	public void update(SomAspchief somAspchief){
		somAspchiefDao.update(somAspchief);
	}

	/**
	 * 删除拟任负责人
	 * @param id
	 */
	public void delete(String id) {
		somAspchiefDao.delete(id);
	}
	
	/**
	 * 通过社会组织内码删除所有拟任负责人
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId) {
		somAspchiefDao.deleteBySorgId(sorgId);
	}
	
	/**
	 * 批量增加社会组织拟任负责人
	 * @param lists
	 */
	public void batchInsert(List<SomAspchief> lists) {
		somAspchiefDao.batchInsert(lists);
	}
	
	/**
	 * 批量更新社会组织拟任负责人
	 * @param lists
	 */
	public void batchUpdate(List<SomAspchief> lists) {
		somAspchiefDao.batchUpdate(lists);
	}

	public void deleteAllAspchiefByTaskCode(String taskCode) {
		somAspchiefDao.deleteAllAspchiefByTaskCode(taskCode);
		
	}
	
}
