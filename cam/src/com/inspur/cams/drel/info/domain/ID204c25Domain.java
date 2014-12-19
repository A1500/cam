package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c25;

/**
 * 基金domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c25Domain {

	/**
	 * 查询 基金
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 基金
	 * @param pset
	 * @return
	 */
	public D204c25 get(String d204c25Id);

	/**
	 * 增加 基金
	 * @param d204c25
	 */
	@Trans
	public void insert(D204c25 d204c25);
	
	/**
	 * 修改 基金
	 * @param d204c25
	 */
	@Trans
	public void update(D204c25 d204c25);
	
	/**
	 * 删除 基金
	 * @param d204c25Id
	 */
	@Trans
	public void delete(String d204c25Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}