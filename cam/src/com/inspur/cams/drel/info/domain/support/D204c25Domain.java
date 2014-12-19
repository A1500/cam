package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.info.dao.ID204c25Dao;
import com.inspur.cams.drel.info.data.D204c25;
import com.inspur.cams.drel.info.domain.ID204c25Domain;

/**
 * 基金domain
 * @author 
 * @date 2014-06-09
 */
public class D204c25Domain implements ID204c25Domain {

	@Reference
	private ID204c25Dao d204c25Dao;
	/**
	 * 查询 基金
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c25Dao.query(pset);
	}

	/**
	 * 获取 基金
	 * @param pset
	 * @return
	 */
	public D204c25 get(String d204c25Id) {
		return d204c25Dao.get(d204c25Id);
	}

	/**
	 * 增加 基金
	 * @param d204c25
	 */
	public void insert(D204c25 d204c25) {
		d204c25.setD204c25Id(IdHelp.getUUID32());
		d204c25Dao.insert(d204c25);
	}
	
	/**
	 * 修改 基金
	 * @param d204c25
	 */
	public void update(D204c25 d204c25) {
		d204c25Dao.update(d204c25);
	}
	
	/**
	 * 删除 基金
	 * @param d204c25Id
	 */
	public void delete(String d204c25Id) {
		d204c25Dao.delete(d204c25Id);
	}

	public void insertFromTemp(Record[] records) {
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}
		
}