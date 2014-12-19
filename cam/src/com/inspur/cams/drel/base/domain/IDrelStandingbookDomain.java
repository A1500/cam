package com.inspur.cams.drel.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.base.data.DrelStandingbook;

/**
 * 台账表domain
 * @author 
 * @date 2013-09-09
 */
public interface IDrelStandingbookDomain {

	/**
	 * 查询 台账表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 台账表
	 * @param pset
	 * @return
	 */
	public DrelStandingbook get(String domicileCode);

	/**
	 * 增加 台账表
	 * @param drelStandingbook
	 */
	@Trans
	public void insert(DrelStandingbook drelStandingbook);
	
	/**
	 * 修改 台账表
	 * @param drelStandingbook
	 */
	@Trans
	public void update(DrelStandingbook drelStandingbook);
	
	/**
	 * 删除 台账表
	 * @param domicileCode
	 */
	@Trans
	public void delete(String domicileCode);
	
	/**
	 *  台账表导出查询
	 * @param domicileCode
	 */
	@Trans
	public DataSet queryInfo(ParameterSet pset);

}