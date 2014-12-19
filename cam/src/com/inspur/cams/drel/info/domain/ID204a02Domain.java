package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204a02;

/**
 * 家庭成员就业信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204a02Domain {

	/**
	 * 查询 家庭成员就业信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 家庭成员就业信息
	 * @param pset
	 * @return
	 */
	public D204a02 get(String d204a02Id);

	/**
	 * 增加 家庭成员就业信息
	 * @param d204a02
	 */
	@Trans
	public void insert(D204a02 d204a02);
	
	/**
	 * 修改 家庭成员就业信息
	 * @param d204a02
	 */
	@Trans
	public void update(D204a02 d204a02);
	
	/**
	 * 删除 家庭成员就业信息
	 * @param d204a02Id
	 */
	@Trans
	public void delete(String d204a02Id);

}