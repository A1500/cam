package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c26;

/**
 * 商业保险domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c26Domain {

	/**
	 * 查询 商业保险
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 商业保险
	 * @param pset
	 * @return
	 */
	public D204c26 get(String d204c26Id);

	/**
	 * 增加 商业保险
	 * @param d204c26
	 */
	@Trans
	public void insert(D204c26 d204c26);
	
	/**
	 * 修改 商业保险
	 * @param d204c26
	 */
	@Trans
	public void update(D204c26 d204c26);
	
	/**
	 * 删除 商业保险
	 * @param d204c26Id
	 */
	@Trans
	public void delete(String d204c26Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}