package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c28;

/**
 * 期货domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c28Domain {

	/**
	 * 查询 期货
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 期货
	 * @param pset
	 * @return
	 */
	public D204c28 get(String d204c28Id);

	/**
	 * 增加 期货
	 * @param d204c28
	 */
	@Trans
	public void insert(D204c28 d204c28);
	
	/**
	 * 修改 期货
	 * @param d204c28
	 */
	@Trans
	public void update(D204c28 d204c28);
	
	/**
	 * 删除 期货
	 * @param d204c28Id
	 */
	@Trans
	public void delete(String d204c28Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}