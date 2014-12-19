package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204d36Dao;
import com.inspur.cams.drel.info.data.D204d36;
import com.inspur.cams.drel.info.domain.ID204d36Domain;

/**
 * 大额支出domain
 * @author 
 * @date 2014-06-09
 */
public class D204d36Domain implements ID204d36Domain {

	@Reference
	private ID204d36Dao d204d36Dao;

	/**
	 * 查询 大额支出
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d36Dao.query(pset);
	}

	/**
	 * 获取 大额支出
	 * @param pset
	 * @return
	 */
	public D204d36 get(String d204d36Id) {
		return d204d36Dao.get(d204d36Id);
	}

	/**
	 * 增加 大额支出
	 * @param d204d36
	 */
	public void insert(D204d36 d204d36) {
		d204d36.setD204d36Id(IdHelp.getUUID32());
		d204d36.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204d36.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204d36.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204d36.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204d36.setInputTime(DateUtil.getTime());
		d204d36Dao.insert(d204d36);
	}
	
	/**
	 * 修改 大额支出
	 * @param d204d36
	 */
	public void update(D204d36 d204d36) {
		d204d36Dao.update(d204d36);
	}
	
	/**
	 * 删除 大额支出
	 * @param d204d36Id
	 */
	public void delete(String d204d36Id) {
		d204d36Dao.delete(d204d36Id);
	}

}