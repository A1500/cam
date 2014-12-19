package com.inspur.cams.drel.info.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204z57;

/**
 * 财政供养人员工资信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204z57Domain {

	/**
	 * 查询 财政供养人员工资信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 财政供养人员工资信息
	 * @param pset
	 * @return
	 */
	public D204z57 get(String d204z57Id);

	/**
	 * 增加 财政供养人员工资信息
	 * @param d204z57
	 */
	@Trans
	public void insert(D204z57 d204z57);
	
	/**
	 * 修改 财政供养人员工资信息
	 * @param d204z57
	 */
	@Trans
	public void update(D204z57 d204z57);
	
	/**
	 * 删除 财政供养人员工资信息
	 * @param d204z57Id
	 */
	@Trans
	public void delete(String d204z57Id);
	@Trans
	public void save(List list);

}