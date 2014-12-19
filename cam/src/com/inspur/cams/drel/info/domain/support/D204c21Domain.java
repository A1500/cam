package com.inspur.cams.drel.info.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204c21Dao;
import com.inspur.cams.drel.info.data.D204c21;
import com.inspur.cams.drel.info.domain.ID204c21Domain;

/**
 * 车辆domain
 * @author 
 * @date 2014-06-09
 */
public class D204c21Domain implements ID204c21Domain {

	@Reference
	private ID204c21Dao d204c21Dao;
	/**
	 * 查询 车辆
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c21Dao.query(pset);
	}
	public DataSet querySamFamilyListForRecheck(ParameterSet pset){
		return d204c21Dao.queryCheliang(pset);
	}
	

	/**
	 * 获取 车辆
	 * @param pset
	 * @return
	 */
	public D204c21 get(String d204c21Id) {
		return d204c21Dao.get(d204c21Id);
	}

	/**
	 * 增加 车辆
	 * @param d204c21
	 */
	public void insert(D204c21 d204c21) {
	}
	
	/**
	 * 修改 车辆
	 * @param d204c21
	 */
	public void update(D204c21 d204c21) {
		d204c21Dao.update(d204c21);
	}
	
	/**
	 * 删除 车辆
	 * @param d204c21Id
	 */
	public void delete(String d204c21Id) {
		d204c21Dao.delete(d204c21Id);
	}
	public void insertFromTemp(Record[] records){
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}
	
	public void save(List list) {
		d204c21Dao.batchInsert(list);
	}

	public DataSet queryCheliang(ParameterSet pset) {
		// TODO Auto-generated method stub
		return d204c21Dao.queryCheliang(pset);
	}
}