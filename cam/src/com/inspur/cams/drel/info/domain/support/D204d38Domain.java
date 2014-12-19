package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204d38Dao;
import com.inspur.cams.drel.info.data.D204d38;
import com.inspur.cams.drel.info.domain.ID204d38Domain;

/**
 * 地税-个人所得税domain
 * @author 
 * @date 2014-08-26
 */
public class D204d38Domain implements ID204d38Domain {

	@Reference
	private ID204d38Dao d204d38Dao;

	/**
	 * 查询 地税-个人所得税
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d38Dao.query(pset);
	}

	/**
	 * 获取 地税-个人所得税
	 * @param pset
	 * @return
	 */
	public D204d38 get(String d204d38Id) {
		return d204d38Dao.get(d204d38Id);
	}

	/**
	 * 增加 地税-个人所得税
	 * @param d204d38
	 */
	public void insert(D204d38 d204d38) {
		d204d38Dao.insert(d204d38);
	}
	
	/**
	 * 修改 地税-个人所得税
	 * @param d204d38
	 */
	public void update(D204d38 d204d38) {
		d204d38Dao.update(d204d38);
	}
	
	/**
	 * 删除 地税-个人所得税
	 * @param d204d38Id
	 */
	public void delete(String d204d38Id) {
		d204d38Dao.delete(d204d38Id);
	}

}