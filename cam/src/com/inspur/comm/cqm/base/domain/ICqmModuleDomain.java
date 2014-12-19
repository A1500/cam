package com.inspur.comm.cqm.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.comm.cqm.base.data.CqmModule;

/**
 * 自定义统计报表模型表domain
 * @author shgtch
 * @date 2012-03-16
 */
public interface ICqmModuleDomain {

	/**
	 * 查询 自定义统计报表模型表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加 自定义统计报表模型表
	 * @param cqmModule
	 */
	@Trans
	public void insert(CqmModule cqmModule);
	
	/**
	 * 修改 自定义统计报表模型表
	 * @param cqmModule
	 */
	@Trans
	public void update(CqmModule cqmModule);
	
	/**
	 * 删除 自定义统计报表模型表
	 * @param moduleId
	 */
	@Trans
	public void delete(String moduleId);

	/**
	 * 自己拼装
	 * @param pset
	 * @return
	 */
	public DataSet queryModule(ParameterSet pset);

}