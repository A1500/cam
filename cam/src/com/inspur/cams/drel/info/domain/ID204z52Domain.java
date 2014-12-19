package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z52;

/**
 * 救助信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z52Domain {

	/**
	 * 查询 救助信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 救助信息
	 * @param pset
	 * @return
	 */
	public D204z52 get(String d204z52Id);

	/**
	 * 增加 救助信息
	 * @param d204z52
	 */
	@Trans
	public void insert(D204z52 d204z52);
	
	/**
	 * 修改 救助信息
	 * @param d204z52
	 */
	@Trans
	public void update(D204z52 d204z52);
	
	/**
	 * 删除 救助信息
	 * @param d204z52Id
	 */
	@Trans
	public void delete(String d204z52Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);

}