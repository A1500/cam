package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d33;

/**
 * 纳税情况domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204d33Domain {

	/**
	 * 查询 纳税情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 纳税情况
	 * @param pset
	 * @return
	 */
	public D204d33 get(String d204d33Id);

	/**
	 * 增加 纳税情况
	 * @param d204d33
	 */
	@Trans
	public void insert(D204d33 d204d33);
	
	/**
	 * 修改 纳税情况
	 * @param d204d33
	 */
	@Trans
	public void update(D204d33 d204d33);
	
	/**
	 * 删除 纳税情况
	 * @param d204d33Id
	 */
	@Trans
	public void delete(String d204d33Id);
	@Trans
	public DataSet queryGuoshui(ParameterSet pset);

}