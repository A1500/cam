package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c21Die;

/**
 * 车辆domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c21DieDomain {

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
	public D204c21Die get(String D204c21DieId);

	/**
	 * 增加 车辆
	 * @param D204c21Die
	 */
	@Trans
	public void insert(D204c21Die D204c21Die);
	
	/**
	 * 修改 车辆
	 * @param D204c21Die
	 */
	@Trans
	public void update(D204c21Die D204c21Die);
	
	/**
	 * 删除 车辆
	 * @param D204c21DieId
	 */
	@Trans
	public void delete(String D204c21DieId);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
}