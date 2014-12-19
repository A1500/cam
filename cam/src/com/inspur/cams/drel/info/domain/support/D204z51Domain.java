package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204z51Dao;
import com.inspur.cams.drel.info.data.D204z51;
import com.inspur.cams.drel.info.domain.ID204z51Domain;

/**
 * 教育信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z51Domain implements ID204z51Domain {

	@Reference
	private ID204z51Dao d204z51Dao;

	/**
	 * 查询 教育信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z51Dao.query(pset);
	}

	/**
	 * 获取 教育信息
	 * @param pset
	 * @return
	 */
	public D204z51 get(String d204z51Id) {
		return d204z51Dao.get(d204z51Id);
	}

	/**
	 * 增加 教育信息
	 * @param d204z51
	 */
	public void insert(D204z51 d204z51) {
		d204z51.setD204z51Id(IdHelp.getUUID32());
		d204z51.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204z51.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204z51.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204z51.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204z51.setInputTime(DateUtil.getTime());
		d204z51Dao.insert(d204z51);
	}
	
	/**
	 * 修改 教育信息
	 * @param d204z51
	 */
	public void update(D204z51 d204z51) {
		d204z51Dao.update(d204z51);
	}
	
	/**
	 * 删除 教育信息
	 * @param d204z51Id
	 */
	public void delete(String d204z51Id) {
		d204z51Dao.delete(d204z51Id);
	}

}