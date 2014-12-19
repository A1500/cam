package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204z63Dao;
import com.inspur.cams.drel.info.data.D204z63;
import com.inspur.cams.drel.info.domain.ID204z63Domain;


/**
 * 婚姻信息domain
 * @author 
 * @date 2014-08-21
 */
public class D204z63Domain implements ID204z63Domain {

	@Reference
	private ID204z63Dao d204z63Dao;

	/**
	 * 查询 婚姻信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z63Dao.query(pset);
	}

	/**
	 * 获取 婚姻信息
	 * @param pset
	 * @return
	 */
	public D204z63 get(String d204z63Id) {
		return d204z63Dao.get(d204z63Id);
	}

	/**
	 * 增加 婚姻信息
	 * @param d204z63
	 */
	public void insert(D204z63 d204z63) {
		d204z63Dao.insert(d204z63);
	}
	
	/**
	 * 修改 婚姻信息
	 * @param d204z63
	 */
	public void update(D204z63 d204z63) {
		d204z63Dao.update(d204z63);
	}
	
	/**
	 * 删除 婚姻信息
	 * @param d204z63Id
	 */
	public void delete(String d204z63Id) {
		d204z63Dao.delete(d204z63Id);
	}

	public DataSet queryMarry(ParameterSet pset) {
		// TODO Auto-generated method stub
		return d204z63Dao.queryMarry(pset);
	}

}