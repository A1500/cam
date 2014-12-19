package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeLogoff;

/**
 * 公墓撤销备案表domain
 * @author 
 * @date 2013-08-01
 */
public interface IFisCemeLogoffDomain {

	/**
	 * 查询 公墓撤销备案表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公墓撤销备案表
	 * @param pset
	 * @return
	 */
	public FisCemeLogoff get(String logoffId);

	/**
	 * 增加 公墓撤销备案表
	 * @param fisCemeLogoff
	 */
	@Trans
	public void insert(FisCemeLogoff fisCemeLogoff);
	
	/**
	 * 修改 公墓撤销备案表
	 * @param fisCemeLogoff
	 */
	@Trans
	public void update(FisCemeLogoff fisCemeLogoff);
	
	/**
	 * 删除 公墓撤销备案表
	 * @param logoffId
	 */
	@Trans
	public void delete(String logoffId);

}