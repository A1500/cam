package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204a02Dao;
import com.inspur.cams.drel.info.data.D204a02;
import com.inspur.cams.drel.info.domain.ID204a02Domain;

/**
 * 家庭成员就业信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204a02Domain implements ID204a02Domain {

	@Reference
	private ID204a02Dao d204a02Dao;

	/**
	 * 查询 家庭成员就业信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204a02Dao.query(pset);
	}

	/**
	 * 获取 家庭成员就业信息
	 * @param pset
	 * @return
	 */
	public D204a02 get(String d204a02Id) {
		return d204a02Dao.get(d204a02Id);
	}

	/**
	 * 增加 家庭成员就业信息
	 * @param d204a02
	 */
	public void insert(D204a02 d204a02) {
		d204a02Dao.insert(d204a02);
	}
	
	/**
	 * 修改 家庭成员就业信息
	 * @param d204a02
	 */
	public void update(D204a02 d204a02) {
		d204a02Dao.update(d204a02);
	}
	
	/**
	 * 删除 家庭成员就业信息
	 * @param d204a02Id
	 */
	public void delete(String d204a02Id) {
		d204a02Dao.delete(d204a02Id);
	}

}