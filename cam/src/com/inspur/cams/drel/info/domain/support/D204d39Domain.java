package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204d39Dao;
import com.inspur.cams.drel.info.data.D204d39;
import com.inspur.cams.drel.info.domain.ID204d39Domain;

/**
 * 地税-投资方纳税信息domain
 * @author 
 * @date 2014-08-26
 */
public class D204d39Domain implements ID204d39Domain {

	@Reference
	private ID204d39Dao d204d39Dao;

	/**
	 * 查询 地税-投资方纳税信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d39Dao.query(pset);
	}

	/**
	 * 获取 地税-投资方纳税信息
	 * @param pset
	 * @return
	 */
	public D204d39 get(String d204d39Id) {
		return d204d39Dao.get(d204d39Id);
	}

	/**
	 * 增加 地税-投资方纳税信息
	 * @param d204d39
	 */
	public void insert(D204d39 d204d39) {
		d204d39Dao.insert(d204d39);
	}
	
	/**
	 * 修改 地税-投资方纳税信息
	 * @param d204d39
	 */
	public void update(D204d39 d204d39) {
		d204d39Dao.update(d204d39);
	}
	
	/**
	 * 删除 地税-投资方纳税信息
	 * @param d204d39Id
	 */
	public void delete(String d204d39Id) {
		d204d39Dao.delete(d204d39Id);
	}

}