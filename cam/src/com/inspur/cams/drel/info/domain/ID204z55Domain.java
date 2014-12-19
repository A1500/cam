package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z55;

/**
 * 优待抚恤信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z55Domain {

	/**
	 * 查询 优待抚恤信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 优待抚恤信息
	 * @param pset
	 * @return
	 */
	public D204z55 get(String d204z55Id);

	/**
	 * 增加 优待抚恤信息
	 * @param d204z55
	 */
	@Trans
	public void insert(D204z55 d204z55);
	
	/**
	 * 修改 优待抚恤信息
	 * @param d204z55
	 */
	@Trans
	public void update(D204z55 d204z55);
	
	/**
	 * 删除 优待抚恤信息
	 * @param d204z55Id
	 */
	@Trans
	public void delete(String d204z55Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}