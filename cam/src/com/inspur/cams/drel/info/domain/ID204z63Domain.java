package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z63;


/**
 * 婚姻信息domain
 * @author 
 * @date 2014-08-21
 */
public interface ID204z63Domain {

	/**
	 * 查询 婚姻信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 婚姻信息
	 * @param pset
	 * @return
	 */
	public D204z63 get(String d204z63Id);

	/**
	 * 增加 婚姻信息
	 * @param d204z63
	 */
	@Trans
	public void insert(D204z63 d204z63);
	
	/**
	 * 修改 婚姻信息
	 * @param d204z63
	 */
	@Trans
	public void update(D204z63 d204z63);
	
	/**
	 * 删除 婚姻信息
	 * @param d204z63Id
	 */
	@Trans
	public void delete(String d204z63Id);
	@Trans
	public DataSet queryMarry(ParameterSet pset);

}