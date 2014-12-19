package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204z54Dao;
import com.inspur.cams.drel.info.data.D204z54;
import com.inspur.cams.drel.info.domain.ID204z54Domain;

/**
 * 社会组织管理信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z54Domain implements ID204z54Domain {

	@Reference
	private ID204z54Dao d204z54Dao;
	@Reference
	/**
	 * 查询 社会组织管理信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z54Dao.query(pset);
	}

	/**
	 * 获取 社会组织管理信息
	 * @param pset
	 * @return
	 */
	public D204z54 get(String d204z54Id) {
		return d204z54Dao.get(d204z54Id);
	}

	/**
	 * 增加 社会组织管理信息
	 * @param d204z54
	 */
	public void insert(D204z54 d204z54) {
	}
	
	/**
	 * 修改 社会组织管理信息
	 * @param d204z54
	 */
	public void update(D204z54 d204z54) {
		d204z54Dao.update(d204z54);
	}
	
	/**
	 * 删除 社会组织管理信息
	 * @param d204z54Id
	 */
	public void delete(String d204z54Id) {
		d204z54Dao.delete(d204z54Id);
	}
	public void insertFromTemp(Record[] records) {
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}

	public DataSet queryMinfei(ParameterSet pset) {
		// TODO Auto-generated method stub
		return d204z54Dao.queryMinfei(pset);
	}
}