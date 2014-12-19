package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204a04Dao;
import com.inspur.cams.drel.info.data.D204a04;
import com.inspur.cams.drel.info.domain.ID204a04Domain;

/**
 * 区划信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204a04Domain implements ID204a04Domain {

	@Reference
	private ID204a04Dao d204a04Dao;

	/**
	 * 查询 区划信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204a04Dao.query(pset);
	}

	/**
	 * 获取 区划信息
	 * @param pset
	 * @return
	 */
	public D204a04 get(String d204a04Id) {
		return d204a04Dao.get(d204a04Id);
	}

	/**
	 * 增加 区划信息
	 * @param d204a04
	 */
	public void insert(D204a04 d204a04) {
		d204a04Dao.insert(d204a04);
	}
	
	/**
	 * 修改 区划信息
	 * @param d204a04
	 */
	public void update(D204a04 d204a04) {
		d204a04Dao.update(d204a04);
	}
	
	/**
	 * 删除 区划信息
	 * @param d204a04Id
	 */
	public void delete(String d204a04Id) {
		d204a04Dao.delete(d204a04Id);
	}

}