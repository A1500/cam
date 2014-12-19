package com.inspur.cams.drel.info.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204a01;

/**
 * 成员信息domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204a01Domain {

	/**
	 * 查询 成员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 成员信息
	 * @param pset
	 * @return
	 */
	public D204a01 get(String peopleId);

	/**
	 * 增加 成员信息
	 * @param d204a01
	 */
	@Trans
	public void insert(D204a01 d204a01);
	
	/**
	 * 修改 成员信息
	 * @param d204a01
	 */
	@Trans
	public void update(D204a01 d204a01);
	
	/**
	 * 删除 成员信息
	 * @param peopleId
	 */
	@Trans
	public void delete(String peopleId);
	@Trans
	public void insertFromTemp(Record[] records);
	@Trans
	public void batchInsertFromTemp(ParameterSet pset);
	/**
	 * 删除家庭成员及其详细信息
	 */
	@Trans
	public void deletePersonAndInfo(ParameterSet pset);
	
	public DataSet queryPeopleInfo(ParameterSet pset);
	
	public void save(List list);
}