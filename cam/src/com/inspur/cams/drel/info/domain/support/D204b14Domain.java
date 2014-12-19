package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204b14Dao;
import com.inspur.cams.drel.info.data.D204b14;
import com.inspur.cams.drel.info.domain.ID204b14Domain;

/**
 * 转移性收入domain
 * @author 
 * @date 2014-06-09
 */
public class D204b14Domain implements ID204b14Domain {

	@Reference
	private ID204b14Dao d204b14Dao;

	/**
	 * 查询 转移性收入
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204b14Dao.query(pset);
	}

	/**
	 * 获取 转移性收入
	 * @param pset
	 * @return
	 */
	public D204b14 get(String d204b14Id) {
		return d204b14Dao.get(d204b14Id);
	}

	/**
	 * 增加 转移性收入
	 * @param d204b14
	 */
	public void insert(D204b14 d204b14) {
		d204b14Dao.insert(d204b14);
	}
	
	/**
	 * 修改 转移性收入
	 * @param d204b14
	 */
	public void update(D204b14 d204b14) {
		d204b14Dao.update(d204b14);
	}
	
	/**
	 * 删除 转移性收入
	 * @param d204b14Id
	 */
	public void delete(String d204b14Id) {
		d204b14Dao.delete(d204b14Id);
	}

}