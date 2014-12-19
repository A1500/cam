package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204z62Dao;
import com.inspur.cams.drel.info.data.D204z62;
import com.inspur.cams.drel.info.domain.ID204z62Domain;


/**
 * 殡葬信息domain
 * @author 
 * @date 2014-08-21
 */
public class D204z62Domain implements ID204z62Domain {

	@Reference
	private ID204z62Dao d204z62Dao;

	/**
	 * 查询 殡葬信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z62Dao.query(pset);
	}

	/**
	 * 获取 殡葬信息
	 * @param pset
	 * @return
	 */
	public D204z62 get(String d204z62Id) {
		return d204z62Dao.get(d204z62Id);
	}

	/**
	 * 增加 殡葬信息
	 * @param d204z62
	 */
	public void insert(D204z62 d204z62) {
		d204z62Dao.insert(d204z62);
	}
	
	/**
	 * 修改 殡葬信息
	 * @param d204z62
	 */
	public void update(D204z62 d204z62) {
		d204z62Dao.update(d204z62);
	}
	
	/**
	 * 删除 殡葬信息
	 * @param d204z62Id
	 */
	public void delete(String d204z62Id) {
		d204z62Dao.delete(d204z62Id);
	}

	public DataSet queryBinzang(ParameterSet pset) {
		// TODO Auto-generated method stub
		return d204z62Dao.queryBinzang(pset);
	}

}