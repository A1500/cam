package com.inspur.cams.drel.info.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c21;

/**
 * 车辆domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c21Domain {

	/**
	 * 查询 车辆
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 车辆
	 * @param pset
	 * @return
	 */
	public D204c21 get(String d204c21Id);

	/**
	 * 增加 车辆
	 * @param d204c21
	 */
	@Trans
	public void insert(D204c21 d204c21);
	
	/**
	 * 修改 车辆
	 * @param d204c21
	 */
	@Trans
	public void update(D204c21 d204c21);
	
	/**
	 * 删除 车辆
	 * @param d204c21Id
	 */
	@Trans
	public void delete(String d204c21Id);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
	@Trans
	public void save(List list);
	@Trans
	public DataSet queryCheliang(ParameterSet pset);
}