package com.inspur.comm.cqm.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.comm.cqm.base.dao.ICqmModuleDao;
import com.inspur.comm.cqm.base.data.CqmModule;
import com.inspur.comm.cqm.base.domain.ICqmModuleDomain;

/**
 * 自定义统计报表模型表domain
 * @author shgtch
 * @date 2012-03-16
 */
public class CqmModuleDomain implements ICqmModuleDomain {

	@Reference
	private ICqmModuleDao cqmModuleDao;

	/**
	 * 查询 自定义统计报表模型表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cqmModuleDao.query(pset);
	}

	/**
	 * 增加 自定义统计报表模型表
	 * @param cqmModule
	 */
	public void insert(CqmModule cqmModule) {
		cqmModuleDao.insert(cqmModule);
	}
	
	/**
	 * 修改 自定义统计报表模型表
	 * @param cqmModule
	 */
	public void update(CqmModule cqmModule) {
		cqmModuleDao.update(cqmModule);
	}
	
	/**
	 * 删除 自定义统计报表模型表
	 * @param moduleId
	 */
	public void delete(String moduleId) {
		cqmModuleDao.delete(moduleId);
	}

	public DataSet queryModule(ParameterSet pset) {
		return cqmModuleDao.queryModule(pset);
	}

}