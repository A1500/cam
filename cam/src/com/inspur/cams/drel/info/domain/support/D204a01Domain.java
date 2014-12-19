package com.inspur.cams.drel.info.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204a01Dao;
import com.inspur.cams.drel.info.data.D204a01;
import com.inspur.cams.drel.info.domain.ID204a01Domain;

/**
 * 成员信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204a01Domain implements ID204a01Domain {

	@Reference
	private ID204a01Dao d204a01Dao;
	/**
	 * 查询 成员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204a01Dao.query(pset);
	}

	/**
	 * 获取 成员信息
	 * @param pset
	 * @return
	 */
	public D204a01 get(String peopleId) {
		return d204a01Dao.get(peopleId);
	}

	/**
	 * 增加 成员信息
	 * @param d204a01
	 */
	public void insert(D204a01 d204a01) {
	}
	
	/**
	 * 修改 成员信息
	 * @param d204a01
	 */
	public void update(D204a01 d204a01) {
		d204a01Dao.update(d204a01);
	}
	
	/**
	 * 删除 成员信息
	 * @param peopleId
	 */
	public void delete(String peopleId) {
		d204a01Dao.delete(peopleId);
	}
	public void insertFromTemp(Record[] records){
	}
	/**
	 *删除家庭成员及其详细信息
	 */
	public void deletePersonAndInfo(ParameterSet pset){
		d204a01Dao.deletePersonAndInfo(pset);
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}
	
	public DataSet queryPeopleInfo(ParameterSet pset) {
		return d204a01Dao.queryPeopleInfo(pset);
	}
	
	public void save(List list) {
		d204a01Dao.batchInsert(list);
	}
	
}