package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.info.dao.ID204c26Dao;
import com.inspur.cams.drel.info.data.D204c26;
import com.inspur.cams.drel.info.domain.ID204c26Domain;

/**
 * 商业保险domain
 * @author 
 * @date 2014-06-09
 */
public class D204c26Domain implements ID204c26Domain {

	@Reference
	private ID204c26Dao d204c26Dao;
	/**
	 * 查询 商业保险
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204c26Dao.query(pset);
	}

	/**
	 * 获取 商业保险
	 * @param pset
	 * @return
	 */
	public D204c26 get(String d204c26Id) {
		return d204c26Dao.get(d204c26Id);
	}

	/**
	 * 增加 商业保险
	 * @param d204c26
	 */
	public void insert(D204c26 d204c26) {
		d204c26.setD204c26Id(IdHelp.getUUID32());
		d204c26Dao.insert(d204c26);
	}
	
	/**
	 * 修改 商业保险
	 * @param d204c26
	 */
	public void update(D204c26 d204c26) {
		d204c26Dao.update(d204c26);
	}
	
	/**
	 * 删除 商业保险
	 * @param d204c26Id
	 */
	public void delete(String d204c26Id) {
		d204c26Dao.delete(d204c26Id);
	}
	public void insertFromTemp(Record[] records) {
	}
	public void batchInsertFromTemp(ParameterSet pset) {
	}
}