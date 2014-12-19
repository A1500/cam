package com.inspur.cams.drel.info.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204c22Dao;
import com.inspur.cams.drel.info.data.D204c22;
import com.inspur.cams.drel.info.domain.ID204c22Domain;

/**
 * 房产domain
 * @author 
 * @date 2014-06-09
 */
public class D204c22Domain implements ID204c22Domain {

	@Reference
	private ID204c22Dao d204c22Dao;

	/**
	 * 查询 房产
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c22Dao.query(pset);
	}

	public DataSet queryHouse(ParameterSet pset) {
		return d204c22Dao.queryHouse(pset);
	}
	/**
	 * 获取 房产
	 * @param pset
	 * @return
	 */
	public D204c22 get(String d204c22Id) {
		return d204c22Dao.get(d204c22Id);
	}

	/**
	 * 增加 房产
	 * @param d204c22
	 */
	public void insert(D204c22 d204c22) {
	}
	
	/**
	 * 修改 房产
	 * @param d204c22
	 */
	public void update(D204c22 d204c22) {
		d204c22Dao.update(d204c22);
	}
	
	/**
	 * 删除 房产
	 * @param d204c22Id
	 */
	public void delete(String d204c22Id) {
		d204c22Dao.delete(d204c22Id);
	}

	public void batchInsert(List<D204c22> list) {
	}
	public void insertFromTemp(Record[] records){
	}

	public void batchInsertFromTemp(ParameterSet pset) {
	}
	
	public void save(List list) {
		d204c22Dao.batchInsert(list);
	}

	public DataSet queryFangguan(ParameterSet pset) {
		// TODO Auto-generated method stub
		return d204c22Dao.queryFangguan(pset);
	}
}