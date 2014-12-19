package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeChange;

/**
 * 公墓信息变更备案表domain
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeChangeDomain {

	/**
	 * 查询 公墓信息变更备案表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公墓信息变更备案表
	 * @param pset
	 * @return
	 */
	public FisCemeChange get(String changeId);

	/**
	 * 增加 公墓信息变更备案表
	 * @param fisCemeChange
	 */
	@Trans
	public void insert(FisCemeChange fisCemeChange);
	
	/**
	 * 修改 公墓信息变更备案表
	 * @param fisCemeChange
	 */
	@Trans
	public void update(FisCemeChange fisCemeChange);
	
	/**
	 * 删除 公墓信息变更备案表
	 * @param changeId
	 */
	@Trans
	public void delete(String changeId);

}