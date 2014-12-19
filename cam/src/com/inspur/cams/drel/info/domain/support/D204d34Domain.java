package com.inspur.cams.drel.info.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204d34Dao;
import com.inspur.cams.drel.info.data.D204d34;
import com.inspur.cams.drel.info.domain.ID204d34Domain;

/**
 * 公积金缴纳情况domain
 * @author 
 * @date 2014-06-09
 */
public class D204d34Domain implements ID204d34Domain {

	@Reference
	private ID204d34Dao d204d34Dao;

	/**
	 * 查询 公积金缴纳情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d34Dao.query(pset);
	}

	/**
	 * 获取 公积金缴纳情况
	 * @param pset
	 * @return
	 */
	public D204d34 get(String d204d34Id) {
		return d204d34Dao.get(d204d34Id);
	}

	/**
	 * 增加 公积金缴纳情况
	 * @param d204d34
	 */
	public void insert(D204d34 d204d34) {
	}
	
	/**
	 * 修改 公积金缴纳情况
	 * @param d204d34
	 */
	public void update(D204d34 d204d34) {
		d204d34Dao.update(d204d34);
	}
	
	/**
	 * 删除 公积金缴纳情况
	 * @param d204d34Id
	 */
	public void delete(String d204d34Id) {
		d204d34Dao.delete(d204d34Id);
	}
	public void insertFromTemp(Record[] records) {
	}
	
	
	public void batchInsertFromTemp(ParameterSet pset) {
	}
	
	public void save(List list) {
		d204d34Dao.batchInsert(list);
	}
}