package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z53;

/**
 * 司法援助信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z53Domain {

	/**
	 * 查询 司法援助信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 司法援助信息
	 * @param pset
	 * @return
	 */
	public D204z53 get(String d204z53Id);

	/**
	 * 增加 司法援助信息
	 * @param d204z53
	 */
	@Trans
	public void insert(D204z53 d204z53);
	
	/**
	 * 修改 司法援助信息
	 * @param d204z53
	 */
	@Trans
	public void update(D204z53 d204z53);
	
	/**
	 * 删除 司法援助信息
	 * @param d204z53Id
	 */
	@Trans
	public void delete(String d204z53Id);

}