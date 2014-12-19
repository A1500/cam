package com.inspur.cams.drel.info.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204c22;

/**
 * 房产domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204c22Domain {

	/**
	 * 查询 房产
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	public DataSet queryHouse(ParameterSet pset);

	/**
	 * 获取 房产
	 * @param pset
	 * @return
	 */
	public D204c22 get(String d204c22Id);

	/**
	 * 增加 房产
	 * @param d204c22
	 */
	@Trans
	public void insert(D204c22 d204c22);
	
	/**
	 * 修改 房产
	 * @param d204c22
	 */
	@Trans
	public void update(D204c22 d204c22);
	
	/**
	 * 删除 房产
	 * @param d204c22Id
	 */
	@Trans
	public void delete(String d204c22Id);
	/**
	 * 批量录入 房产
	 * @param List<D204c22> list
	 */
	@Trans
	public void batchInsert(List<D204c22> list);
	/**
	 * 录入比对结果
	 * @param records
	 * 2014-07-07
	 */
	@Trans
	public void insertFromTemp(Record[] records);
	/**
	 * 批量录入比对结果
	 * 2014-07-07
	 */
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
	
	public void save(List list);
	@Trans
	public DataSet queryFangguan(ParameterSet pset);

}