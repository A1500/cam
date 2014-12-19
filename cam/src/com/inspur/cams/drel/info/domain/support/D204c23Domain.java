package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204c23Dao;
import com.inspur.cams.drel.info.data.D204c23;
import com.inspur.cams.drel.info.domain.ID204c23Domain;

/**
 * 存款domain
 * @author 
 * @date 2014-06-09
 */
public class D204c23Domain implements ID204c23Domain {

	@Reference
	private ID204c23Dao d204c23Dao;
	/**
	 * 查询 存款
	 * @param pset
	 * @return
	 */
	public DataSet queryBank(ParameterSet pset) {
		return d204c23Dao.queryBank(pset);
	}

	public DataSet query(ParameterSet pset) {
		return d204c23Dao.query(pset);
	}
	/**
	 * 获取 存款
	 * @param pset
	 * @return
	 */
	public D204c23 get(String d204c23Id) {
		return d204c23Dao.get(d204c23Id);
	}

	/**
	 * 增加 存款
	 * @param d204c23
	 */
	public void insert(D204c23 d204c23) {
	}
	
	/**
	 * 修改 存款
	 * @param d204c23
	 */
	public void update(D204c23 d204c23) {
		d204c23Dao.update(d204c23);
	}
	
	/**
	 * 删除 存款
	 * @param d204c23Id
	 */
	public void delete(String d204c23Id) {
		d204c23Dao.delete(d204c23Id);
	}
	public void insertFromTemp(Record[] records){
	}
	public void batchInsertFromTemp(ParameterSet pset) {
		// TODO Auto-generated method stub
	}
}