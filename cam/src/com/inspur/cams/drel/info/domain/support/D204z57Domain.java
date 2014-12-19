package com.inspur.cams.drel.info.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204z57Dao;
import com.inspur.cams.drel.info.data.D204z57;
import com.inspur.cams.drel.info.domain.ID204z57Domain;

/**
 * 财政供养人员工资信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z57Domain implements ID204z57Domain {

	@Reference
	private ID204z57Dao d204z57Dao;

	/**
	 * 查询 财政供养人员工资信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z57Dao.query(pset);
	}

	/**
	 * 获取 财政供养人员工资信息
	 * @param pset
	 * @return
	 */
	public D204z57 get(String d204z57Id) {
		return d204z57Dao.get(d204z57Id);
	}

	/**
	 * 增加 财政供养人员工资信息
	 * @param d204z57
	 */
	public void insert(D204z57 d204z57) {
	}
	
	/**
	 * 修改 财政供养人员工资信息
	 * @param d204z57
	 */
	public void update(D204z57 d204z57) {
		d204z57Dao.update(d204z57);
	}
	
	/**
	 * 删除 财政供养人员工资信息
	 * @param d204z57Id
	 */
	public void delete(String d204z57Id) {
		d204z57Dao.delete(d204z57Id);
	}
	
	public void save(List list) {
		d204z57Dao.save(list);
	}

}