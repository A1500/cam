package com.inspur.cams.drel.info.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d34;

/**
 * 公积金缴纳情况domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204d34Domain {

	/**
	 * 查询 公积金缴纳情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 公积金缴纳情况
	 * @param pset
	 * @return
	 */
	public D204d34 get(String d204d34Id);

	/**
	 * 增加 公积金缴纳情况
	 * @param d204d34
	 */
	@Trans
	public void insert(D204d34 d204d34);
	
	/**
	 * 修改 公积金缴纳情况
	 * @param d204d34
	 */
	@Trans
	public void update(D204d34 d204d34);
	
	/**
	 * 删除 公积金缴纳情况
	 * @param d204d34Id
	 */
	@Trans
	public void delete(String d204d34Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
	@Trans
	public void save(List list);
}