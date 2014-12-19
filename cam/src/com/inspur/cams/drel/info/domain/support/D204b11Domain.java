package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204b11Dao;
import com.inspur.cams.drel.info.data.D204b11;
import com.inspur.cams.drel.info.domain.ID204b11Domain;

/**
 * 工资性收入domain
 * @author 
 * @date 2014-06-09
 */
public class D204b11Domain implements ID204b11Domain {

	@Reference
	private ID204b11Dao d204b11Dao;

	/**
	 * 查询 工资性收入
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204b11Dao.query(pset);
	}

	/**
	 * 获取 工资性收入
	 * @param pset
	 * @return
	 */
	public D204b11 get(String d204b11Id) {
		return d204b11Dao.get(d204b11Id);
	}

	/**
	 * 增加 工资性收入
	 * @param d204b11
	 */
	public void insert(D204b11 d204b11) {
		d204b11Dao.insert(d204b11);
	}
	
	/**
	 * 修改 工资性收入
	 * @param d204b11
	 */
	public void update(D204b11 d204b11) {
		d204b11Dao.update(d204b11);
	}
	
	/**
	 * 删除 工资性收入
	 * @param d204b11Id
	 */
	public void delete(String d204b11Id) {
		d204b11Dao.delete(d204b11Id);
	}

}