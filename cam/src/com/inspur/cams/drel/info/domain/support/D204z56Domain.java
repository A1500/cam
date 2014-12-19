package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204z56Dao;
import com.inspur.cams.drel.info.data.D204z56;
import com.inspur.cams.drel.info.domain.ID204z56Domain;

/**
 * 核对统计信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z56Domain implements ID204z56Domain {

	@Reference
	private ID204z56Dao d204z56Dao;

	/**
	 * 查询 核对统计信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z56Dao.query(pset);
	}

	/**
	 * 获取 核对统计信息
	 * @param pset
	 * @return
	 */
	public D204z56 get(String d204z56Id) {
		return d204z56Dao.get(d204z56Id);
	}

	/**
	 * 增加 核对统计信息
	 * @param d204z56
	 */
	public void insert(D204z56 d204z56) {
		d204z56Dao.insert(d204z56);
	}
	
	/**
	 * 修改 核对统计信息
	 * @param d204z56
	 */
	public void update(D204z56 d204z56) {
		d204z56Dao.update(d204z56);
	}
	
	/**
	 * 删除 核对统计信息
	 * @param d204z56Id
	 */
	public void delete(String d204z56Id) {
		d204z56Dao.delete(d204z56Id);
	}

}