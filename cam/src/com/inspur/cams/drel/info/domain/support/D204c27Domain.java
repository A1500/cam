package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204c27Dao;
import com.inspur.cams.drel.info.data.D204c27;
import com.inspur.cams.drel.info.domain.ID204c27Domain;

/**
 * 券商domain
 * @author 
 * @date 2014-06-09
 */
public class D204c27Domain implements ID204c27Domain {

	@Reference
	private ID204c27Dao d204c27Dao;
	/**
	 * 查询 券商
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c27Dao.query(pset);
	}

	/**
	 * 获取 券商
	 * @param pset
	 * @return
	 */
	public D204c27 get(String d204c27Id) {
		return d204c27Dao.get(d204c27Id);
	}

	/**
	 * 增加 券商
	 * @param d204c27
	 */
	public void insert(D204c27 d204c27) {
	}
	
	/**
	 * 修改 券商
	 * @param d204c27
	 */
	public void update(D204c27 d204c27) {
		d204c27Dao.update(d204c27);
	}
	
	/**
	 * 删除 券商
	 * @param d204c27Id
	 */
	public void delete(String d204c27Id) {
		d204c27Dao.delete(d204c27Id);
	}
	public void insertFromTemp(Record[] records) {
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}
}