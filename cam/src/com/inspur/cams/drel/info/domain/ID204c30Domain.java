package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c30;

/**
 * 贵金属domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c30Domain {

	/**
	 * 查询 贵金属
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 贵金属
	 * @param pset
	 * @return
	 */
	public D204c30 get(String d204c30Id);

	/**
	 * 增加 贵金属
	 * @param d204c30
	 */
	@Trans
	public void insert(D204c30 d204c30);
	
	/**
	 * 修改 贵金属
	 * @param d204c30
	 */
	@Trans
	public void update(D204c30 d204c30);
	
	/**
	 * 删除 贵金属
	 * @param d204c30Id
	 */
	@Trans
	public void delete(String d204c30Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}