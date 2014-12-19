package com.inspur.cams.drel.special.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.special.dao.ISpecialpoorSupportRefDao;
import com.inspur.cams.drel.special.data.SpecialpoorSupportRef;
import com.inspur.cams.drel.special.domain.ISpecialpoorSupportRefDomain;

/**
 * 帮扶关系表domain
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorSupportRefDomain implements ISpecialpoorSupportRefDomain {

	@Reference
	private ISpecialpoorSupportRefDao specialpoorSupportRefDao;

	/**
	 * 查询 帮扶关系表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return specialpoorSupportRefDao.query(pset);
	}

	/**
	 * 获取 帮扶关系表
	 * @param pset
	 * @return
	 */
	public SpecialpoorSupportRef get(String recordId) {
		return specialpoorSupportRefDao.get(recordId);
	}

	/**
	 * 增加 帮扶关系表
	 * @param specialpoorSupportRef
	 */
	public void insert(SpecialpoorSupportRef specialpoorSupportRef) {
		specialpoorSupportRefDao.insert(specialpoorSupportRef);
	}
	
	/**
	 * 修改 帮扶关系表
	 * @param specialpoorSupportRef
	 */
	public void update(SpecialpoorSupportRef specialpoorSupportRef) {
		specialpoorSupportRefDao.update(specialpoorSupportRef);
	}
	
	/**
	 * 删除 帮扶关系表
	 * @param recordId
	 */
	public void delete(String recordId) {
		specialpoorSupportRefDao.delete(recordId);
	}

	/**
	 * 查询帮扶单位与帮扶村的关系数据
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorSupportRef(ParameterSet pset) {
		return specialpoorSupportRefDao.querySpecialpoorSupportRef(pset);
	}

	public void batchInsert(List<SpecialpoorSupportRef> specialpoorSupportRefList) {
		specialpoorSupportRefDao.batchInsert(specialpoorSupportRefList);
	}

	/**
	 * 查询帮扶单位指定的帮扶村数据
	 * @author xuexzh
	 */
	public DataSet querySpecialpoorHelpVillage(ParameterSet pset) {
		return specialpoorSupportRefDao.querySpecialpoorHelpVillage(pset);
	}
}