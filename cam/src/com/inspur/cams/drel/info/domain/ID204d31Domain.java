package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d31;

/**
 * 公共事业缴费domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204d31Domain {

	/**
	 * 查询 公共事业缴费
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公共事业缴费
	 * @param pset
	 * @return
	 */
	public D204d31 get(String d204d31Id);

	/**
	 * 增加 公共事业缴费
	 * @param d204d31
	 */
	@Trans
	public void insert(D204d31 d204d31);
	
	/**
	 * 修改 公共事业缴费
	 * @param d204d31
	 */
	@Trans
	public void update(D204d31 d204d31);
	
	/**
	 * 删除 公共事业缴费
	 * @param d204d31Id
	 */
	@Trans
	public void delete(String d204d31Id);

}