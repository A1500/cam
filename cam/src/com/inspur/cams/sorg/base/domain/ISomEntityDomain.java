package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomEntity;

/**
 * 社会组织举办实体domain接口
 * @author shgtch
 * @date 2011-5-11
 */
public interface ISomEntityDomain {

	/**
	 * 查询社会组织举办实体
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会组织举办实体
	 * @param somEntity
	 */
	@Trans
	public void insert(SomEntity somEntity);
	
	/**
	 * 更新社会组织举办实体
	 * @param somEntity
	 */
	@Trans
	public void update(SomEntity somEntity);
	
	@Trans
	public void del(String taskCode);
	
}
