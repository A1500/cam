package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d38;

/**
 * 地税-个人所得税domain
 * @author 
 * @date 2014-08-26
 */
public interface ID204d38Domain {

	/**
	 * 查询 地税-个人所得税
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 地税-个人所得税
	 * @param pset
	 * @return
	 */
	public D204d38 get(String d204d38Id);

	/**
	 * 增加 地税-个人所得税
	 * @param d204d38
	 */
	@Trans
	public void insert(D204d38 d204d38);
	
	/**
	 * 修改 地税-个人所得税
	 * @param d204d38
	 */
	@Trans
	public void update(D204d38 d204d38);
	
	/**
	 * 删除 地税-个人所得税
	 * @param d204d38Id
	 */
	@Trans
	public void delete(String d204d38Id);

}