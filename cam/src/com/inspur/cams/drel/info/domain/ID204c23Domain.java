package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c23;

/**
 * 存款domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c23Domain {

	/**
	 * 查询 存款
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	public DataSet queryBank(ParameterSet pset);

	/**
	 * 获取 存款
	 * @param pset
	 * @return
	 */
	public D204c23 get(String d204c23Id);

	/**
	 * 增加 存款
	 * @param d204c23
	 */
	@Trans
	public void insert(D204c23 d204c23);
	
	/**
	 * 修改 存款
	 * @param d204c23
	 */
	@Trans
	public void update(D204c23 d204c23);
	
	/**
	 * 删除 存款
	 * @param d204c23Id
	 */
	@Trans
	public void delete(String d204c23Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}