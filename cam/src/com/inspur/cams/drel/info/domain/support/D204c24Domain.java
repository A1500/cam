package com.inspur.cams.drel.info.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.info.dao.ID204c24Dao;
import com.inspur.cams.drel.info.data.D204c24;
import com.inspur.cams.drel.info.domain.ID204c24Domain;

/**
 * 股票domain
 * @author 
 * @date 2014-06-09
 */
public class D204c24Domain implements ID204c24Domain {

	@Reference
	private ID204c24Dao d204c24Dao;
	/**
	 * 查询 股票
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c24Dao.query(pset);
	}

	/**
	 * 获取 股票
	 * @param pset
	 * @return
	 */
	public D204c24 get(String d204c24Id) {
		return d204c24Dao.get(d204c24Id);
	}

	/**
	 * 增加 股票
	 * @param d204c24
	 */
	public void insert(D204c24 d204c24) {
		d204c24.setD204c24Id(IdHelp.getUUID32());
		d204c24Dao.insert(d204c24);
	}
	
	/**
	 * 修改 股票
	 * @param d204c24
	 */
	public void update(D204c24 d204c24) {
		d204c24Dao.update(d204c24);
	}
	
	/**
	 * 删除 股票
	 * @param d204c24Id
	 */
	public void delete(String d204c24Id) {
		d204c24Dao.delete(d204c24Id);
	}

	public void batchInsert(List<D204c24> list) {
	}
	public void insertFromTemp(Record[] records){
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}
}