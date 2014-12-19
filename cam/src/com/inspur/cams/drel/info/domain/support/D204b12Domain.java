package com.inspur.cams.drel.info.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204b12Dao;
import com.inspur.cams.drel.info.data.D204b12;
import com.inspur.cams.drel.info.domain.ID204b12Domain;

/**
 * 经营性收入domain
 * @author 
 * @date 2014-06-09
 */
public class D204b12Domain implements ID204b12Domain {

	@Reference
	private ID204b12Dao d204b12Dao;

	/**
	 * 查询 经营性收入
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204b12Dao.query(pset);
	}

	/**
	 * 获取 经营性收入
	 * @param pset
	 * @return
	 */
	public D204b12 get(String d204b12Id) {
		return d204b12Dao.get(d204b12Id);
	}

	/**
	 * 增加 经营性收入
	 * @param d204b12
	 */
	public void insert(D204b12 d204b12) {
		d204b12Dao.insert(d204b12);
	}
	
	/**
	 * 修改 经营性收入
	 * @param d204b12
	 */
	public void update(D204b12 d204b12) {
		d204b12Dao.update(d204b12);
	}
	
	/**
	 * 删除 经营性收入
	 * @param d204b12Id
	 */
	public void delete(String d204b12Id) {
		d204b12Dao.delete(d204b12Id);
	}
	
	public void save(List list) {
		d204b12Dao.batchInsert(list);
	}

	public DataSet queryGongshang(ParameterSet pset) {
		// TODO Auto-generated method stub
		return d204b12Dao.queryGongshang(pset);
	}

	
	
	

}