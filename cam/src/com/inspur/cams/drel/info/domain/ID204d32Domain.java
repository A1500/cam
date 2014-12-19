package com.inspur.cams.drel.info.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d32;

/**
 * 社会保险缴费domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204d32Domain {

	/**
	 * 查询 社会保险缴费
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 社会保险缴费
	 * @param pset
	 * @return
	 */
	public D204d32 get(String d204d32Id);

	/**
	 * 增加 社会保险缴费
	 * @param d204d32
	 */
	@Trans
	public void insert(D204d32 d204d32);
	
	/**
	 * 修改 社会保险缴费
	 * @param d204d32
	 */
	@Trans
	public void update(D204d32 d204d32);
	
	/**
	 * 删除 社会保险缴费
	 * @param d204d32Id
	 */
	@Trans
	public void delete(String d204d32Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
	@Trans
	public void save(List list);
	@Trans
	public DataSet queryShebao(ParameterSet pset);
}