package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204z58Dao;
import com.inspur.cams.drel.info.data.D204z58;
import com.inspur.cams.drel.info.domain.ID204z58Domain;

/**
 * 涉农信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z58Domain implements ID204z58Domain {

	@Reference
	private ID204z58Dao d204z58Dao;

	/**
	 * 查询 涉农信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z58Dao.query(pset);
	}

	/**
	 * 获取 涉农信息
	 * @param pset
	 * @return
	 */
	public D204z58 get(String d204z58Id) {
		return d204z58Dao.get(d204z58Id);
	}

	/**
	 * 增加 涉农信息
	 * @param d204z58
	 */
	public void insert(D204z58 d204z58) {
		d204z58.setD204z58Id(IdHelp.getUUID32());
		d204z58.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204z58.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204z58.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204z58.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204z58.setInputTime(DateUtil.getTime());
		d204z58Dao.insert(d204z58);
	}
	
	/**
	 * 修改 涉农信息
	 * @param d204z58
	 */
	public void update(D204z58 d204z58) {
		d204z58Dao.update(d204z58);
	}
	
	/**
	 * 删除 涉农信息
	 * @param d204z58Id
	 */
	public void delete(String d204z58Id) {
		d204z58Dao.delete(d204z58Id);
	}

}