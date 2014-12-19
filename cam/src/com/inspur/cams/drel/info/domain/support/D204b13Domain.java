package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204b13Dao;
import com.inspur.cams.drel.info.data.D204b13;
import com.inspur.cams.drel.info.domain.ID204b13Domain;

/**
 * 财产性收入domain
 * @author 
 * @date 2014-06-09
 */
public class D204b13Domain implements ID204b13Domain {

	@Reference
	private ID204b13Dao d204b13Dao;

	/**
	 * 查询 财产性收入
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204b13Dao.query(pset);
	}

	/**
	 * 获取 财产性收入
	 * @param pset
	 * @return
	 */
	public D204b13 get(String d204b13Id) {
		return d204b13Dao.get(d204b13Id);
	}

	/**
	 * 增加 财产性收入
	 * @param d204b13
	 */
	public void insert(D204b13 d204b13) {
		d204b13Dao.insert(d204b13);
	}
	
	/**
	 * 修改 财产性收入
	 * @param d204b13
	 */
	public void update(D204b13 d204b13) {
		d204b13Dao.update(d204b13);
	}
	
	/**
	 * 删除 财产性收入
	 * @param d204b13Id
	 */
	public void delete(String d204b13Id) {
		d204b13Dao.delete(d204b13Id);
	}

}