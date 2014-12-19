package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c29;

/**
 * 理财domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c29Domain {

	/**
	 * 查询 理财
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 理财
	 * @param pset
	 * @return
	 */
	public D204c29 get(String d204c29Id);

	/**
	 * 增加 理财
	 * @param d204c29
	 */
	@Trans
	public void insert(D204c29 d204c29);
	
	/**
	 * 修改 理财
	 * @param d204c29
	 */
	@Trans
	public void update(D204c29 d204c29);
	
	/**
	 * 删除 理财
	 * @param d204c29Id
	 */
	@Trans
	public void delete(String d204c29Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}