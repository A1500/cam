package com.inspur.cams.drel.info.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204d32Dao;
import com.inspur.cams.drel.info.data.D204d32;
import com.inspur.cams.drel.info.domain.ID204d32Domain;

/**
 * 社会保险缴费domain
 * @author 
 * @date 2014-06-09
 */
public class D204d32Domain implements ID204d32Domain {

	@Reference
	private ID204d32Dao d204d32Dao;
	/**
	 * 查询 社会保险缴费
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d32Dao.query(pset);
	}

	/**
	 * 获取 社会保险缴费
	 * @param pset
	 * @return
	 */
	public D204d32 get(String d204d32Id) {
		return d204d32Dao.get(d204d32Id);
	}

	/**
	 * 增加 社会保险缴费
	 * @param d204d32
	 */
	public void insert(D204d32 d204d32) {
	}
	
	/**
	 * 修改 社会保险缴费
	 * @param d204d32
	 */
	public void update(D204d32 d204d32) {
		d204d32Dao.update(d204d32);
	}
	
	/**
	 * 删除 社会保险缴费
	 * @param d204d32Id
	 */
	public void delete(String d204d32Id) {
		d204d32Dao.delete(d204d32Id);
	}
	public void insertFromTemp(Record[] records) {
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}
	
	public void save(List list) {
		d204d32Dao.batchInsert(list);
	}

	public DataSet queryShebao(ParameterSet pset) {
		// TODO Auto-generated method stub
		return d204d32Dao.queryShebao(pset);
	}

	
}