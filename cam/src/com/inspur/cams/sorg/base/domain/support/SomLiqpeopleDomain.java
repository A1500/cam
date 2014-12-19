package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.ISomLiqpeopleDao;
import com.inspur.cams.sorg.base.data.SomLiqpeople;
import com.inspur.cams.sorg.base.domain.ISomLiqpeopleDomain;

/**
 * 社会组织清算组织人员domain实现类
 * 
 * @author Muqi
 * @date 2011-5-17
 */
public class SomLiqpeopleDomain implements ISomLiqpeopleDomain {

	@Reference
	private ISomLiqpeopleDao somLiqpeopleDao;

	/**
	 * 查询社会组织清算组织人员
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somLiqpeopleDao.queryNoPage(pset);
	}

	/**
	 * 增加社会组织清算组织人员
	 * 
	 * @param dataBean
	 */
	public void insert(SomLiqpeople dataBean) {
		somLiqpeopleDao.insert(dataBean);
	}
	
	/**
	 * 删除社会组织清算组织人员
	 * 
	 * @param id
	 */
	public void delete(String id) {
		somLiqpeopleDao.delete(id);
	}
	
	/**
	 * 更新社会组织清算组织人员
	 * 
	 * @param dataBean
	 */
	public void update(SomLiqpeople dataBean) {
		somLiqpeopleDao.update(dataBean);
	}

	/**
	 * 批量增加社会组织清算组织人员
	 * 
	 * @param lists
	 */
	public void batchInsert(List<SomLiqpeople> lists) {
		somLiqpeopleDao.batchInsert(lists);

	}
	
	/**
	 * 批量更新社会组织清算组织人员
	 * 
	 * @param lists
	 */
	public void batchUpdate(List<SomLiqpeople> lists) {
		somLiqpeopleDao.batchUpdate(lists);

	}

	/**
	 * 批量增加社会组织清算组织人员
	 * 
	 * @param lists
	 */
	public void save(List<SomLiqpeople> lists) {
		somLiqpeopleDao.save(lists);
	}

	/**
	 * 根据sorgId，删除社会组织清算组织人员
	 * 
	 * @param sorgId
	 */
	public void deleteBySorgId(String sorgId) {
		somLiqpeopleDao.deleteBySorgId(sorgId);
	}
}
