package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z59;

/**
 * 新农合信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z59Domain {

	/**
	 * 查询 新农合信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 新农合信息
	 * @param pset
	 * @return
	 */
	public D204z59 get(String d204z59Id);

	/**
	 * 增加 新农合信息
	 * @param d204z59
	 */
	@Trans
	public void insert(D204z59 d204z59);
	
	/**
	 * 修改 新农合信息
	 * @param d204z59
	 */
	@Trans
	public void update(D204z59 d204z59);
	
	/**
	 * 删除 新农合信息
	 * @param d204z59Id
	 */
	@Trans
	public void delete(String d204z59Id);

}