package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204a00Dao;
import com.inspur.cams.drel.info.data.D204a00;
import com.inspur.cams.drel.info.domain.ID204a00Domain;

/**
 * 核对总体情况domain
 * @author 
 * @date 2014-06-09
 */
public class D204a00Domain implements ID204a00Domain {

	@Reference
	private ID204a00Dao d204a00Dao;

	/**
	 * 查询 核对总体情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204a00Dao.query(pset);
	}

	/**
	 * 获取 核对总体情况
	 * @param pset
	 * @return
	 */
	public D204a00 get(String d204a00Id) {
		return d204a00Dao.get(d204a00Id);
	}

	/**
	 * 增加 核对总体情况
	 * @param d204a00
	 */
	public void insert(D204a00 d204a00) {
		d204a00Dao.insert(d204a00);
	}
	
	/**
	 * 修改 核对总体情况
	 * @param d204a00
	 */
	public void update(D204a00 d204a00) {
		d204a00Dao.update(d204a00);
	}
	
	/**
	 * 删除 核对总体情况
	 * @param d204a00Id
	 */
	public void delete(String d204a00Id) {
		d204a00Dao.delete(d204a00Id);
	}

}