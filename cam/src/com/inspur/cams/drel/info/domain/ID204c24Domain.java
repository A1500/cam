package com.inspur.cams.drel.info.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c24;

/**
 * 股票domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c24Domain {

	/**
	 * 查询 股票
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 股票
	 * @param pset
	 * @return
	 */
	public D204c24 get(String d204c24Id);

	/**
	 * 增加 股票
	 * @param d204c24
	 */
	@Trans
	public void insert(D204c24 d204c24);
	
	/**
	 * 修改 股票
	 * @param d204c24
	 */
	@Trans
	public void update(D204c24 d204c24);
	
	/**
	 * 删除 股票
	 * @param d204c24Id
	 */
	@Trans
	public void delete(String d204c24Id);

	@Trans
	public void batchInsert(List<D204c24> list);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}