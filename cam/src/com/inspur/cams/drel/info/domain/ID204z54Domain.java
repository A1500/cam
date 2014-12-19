package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z54;

/**
 * 社会组织管理信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z54Domain {

	/**
	 * 查询 社会组织管理信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 社会组织管理信息
	 * @param pset
	 * @return
	 */
	public D204z54 get(String d204z54Id);

	/**
	 * 增加 社会组织管理信息
	 * @param d204z54
	 */
	@Trans
	public void insert(D204z54 d204z54);
	
	/**
	 * 修改 社会组织管理信息
	 * @param d204z54
	 */
	@Trans
	public void update(D204z54 d204z54);
	
	/**
	 * 删除 社会组织管理信息
	 * @param d204z54Id
	 */
	@Trans
	public void delete(String d204z54Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
	@Trans
	public DataSet queryMinfei(ParameterSet pset);
}