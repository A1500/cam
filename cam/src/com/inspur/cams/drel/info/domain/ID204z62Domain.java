package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z62;


/**
 * 殡葬信息domain
 * @author 
 * @date 2014-08-21
 */
public interface ID204z62Domain {

	/**
	 * 查询 殡葬信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 殡葬信息
	 * @param pset
	 * @return
	 */
	public D204z62 get(String d204z62Id);

	/**
	 * 增加 殡葬信息
	 * @param d204z62
	 */
	@Trans
	public void insert(D204z62 d204z62);
	
	/**
	 * 修改 殡葬信息
	 * @param d204z62
	 */
	@Trans
	public void update(D204z62 d204z62);
	
	/**
	 * 删除 殡葬信息
	 * @param d204z62Id
	 */
	@Trans
	public void delete(String d204z62Id);
	@Trans
	public DataSet queryBinzang(ParameterSet pset);

}