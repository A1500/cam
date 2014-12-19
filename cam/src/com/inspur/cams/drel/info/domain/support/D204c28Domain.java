package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204c28Dao;
import com.inspur.cams.drel.info.data.D204c28;
import com.inspur.cams.drel.info.domain.ID204c28Domain;

/**
 * 期货domain
 * @author 
 * @date 2014-06-09
 */
public class D204c28Domain implements ID204c28Domain {

	@Reference
	private ID204c28Dao d204c28Dao;
	/**
	 * 查询 期货
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c28Dao.query(pset);
	}

	/**
	 * 获取 期货
	 * @param pset
	 * @return
	 */
	public D204c28 get(String d204c28Id) {
		return d204c28Dao.get(d204c28Id);
	}

	/**
	 * 增加 期货
	 * @param d204c28
	 */
	public void insert(D204c28 d204c28) {
	}
	
	/**
	 * 修改 期货
	 * @param d204c28
	 */
	public void update(D204c28 d204c28) {
		d204c28Dao.update(d204c28);
	}
	
	/**
	 * 删除 期货
	 * @param d204c28Id
	 */
	public void delete(String d204c28Id) {
		d204c28Dao.delete(d204c28Id);
	}
	public void insertFromTemp(Record[] records) {
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}
}