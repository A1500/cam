package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204a03;

/**
 * 家庭基本信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204a03Domain {

	/**
	 * 查询 家庭基本信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 家庭基本信息
	 * @param pset
	 * @return
	 */
	public D204a03 get(String familiyId);

	/**
	 * 增加 家庭基本信息
	 * @param d204a03
	 */
	@Trans
	public void insert(D204a03 d204a03);
	
	/**
	 * 修改 家庭基本信息
	 * @param d204a03
	 */
	@Trans
	public void update(D204a03 d204a03);
	
	/**
	 * 删除 家庭基本信息
	 * @param familiyId
	 */
	@Trans
	public void delete(String familiyId);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}