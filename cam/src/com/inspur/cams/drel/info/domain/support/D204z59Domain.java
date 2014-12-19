package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204z59Dao;
import com.inspur.cams.drel.info.data.D204z59;
import com.inspur.cams.drel.info.domain.ID204z59Domain;

/**
 * 新农合信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z59Domain implements ID204z59Domain {

	@Reference
	private ID204z59Dao d204z59Dao;

	/**
	 * 查询 新农合信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z59Dao.query(pset);
	}

	/**
	 * 获取 新农合信息
	 * @param pset
	 * @return
	 */
	public D204z59 get(String d204z59Id) {
		return d204z59Dao.get(d204z59Id);
	}

	/**
	 * 增加 新农合信息
	 * @param d204z59
	 */
	public void insert(D204z59 d204z59) {
		d204z59.setD204z59Id(IdHelp.getUUID32());
		d204z59.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204z59.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204z59.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204z59.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204z59.setInputTime(DateUtil.getTime());
		d204z59Dao.insert(d204z59);
	}
	
	/**
	 * 修改 新农合信息
	 * @param d204z59
	 */
	public void update(D204z59 d204z59) {
		d204z59Dao.update(d204z59);
	}
	
	/**
	 * 删除 新农合信息
	 * @param d204z59Id
	 */
	public void delete(String d204z59Id) {
		d204z59Dao.delete(d204z59Id);
	}

}