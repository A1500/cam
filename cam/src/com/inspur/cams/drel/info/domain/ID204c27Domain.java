package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c27;

/**
 * 券商domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c27Domain {

	/**
	 * 查询 券商
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 券商
	 * @param pset
	 * @return
	 */
	public D204c27 get(String d204c27Id);

	/**
	 * 增加 券商
	 * @param d204c27
	 */
	@Trans
	public void insert(D204c27 d204c27);
	
	/**
	 * 修改 券商
	 * @param d204c27
	 */
	@Trans
	public void update(D204c27 d204c27);
	
	/**
	 * 删除 券商
	 * @param d204c27Id
	 */
	@Trans
	public void delete(String d204c27Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}