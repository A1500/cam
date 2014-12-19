package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204z61Dao;
import com.inspur.cams.drel.info.data.D204z61;
import com.inspur.cams.drel.info.domain.ID204z61Domain;

/**
 * 船舶信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z61Domain implements ID204z61Domain {

	@Reference
	private ID204z61Dao d204z61Dao;

	/**
	 * 查询 船舶信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z61Dao.query(pset);
	}

	/**
	 * 获取 船舶信息
	 * @param pset
	 * @return
	 */
	public D204z61 get(String d204z61Id) {
		return d204z61Dao.get(d204z61Id);
	}

	/**
	 * 增加 船舶信息
	 * @param d204z61
	 */
	public void insert(D204z61 d204z61) {
		d204z61.setD204z61Id(IdHelp.getUUID32());
		d204z61.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204z61.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204z61.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204z61.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204z61.setInputTime(DateUtil.getTime());
		d204z61Dao.insert(d204z61);
	}
	
	/**
	 * 修改 船舶信息
	 * @param d204z61
	 */
	public void update(D204z61 d204z61) {
		d204z61Dao.update(d204z61);
	}
	
	/**
	 * 删除 船舶信息
	 * @param d204z61Id
	 */
	public void delete(String d204z61Id) {
		d204z61Dao.delete(d204z61Id);
	}

}