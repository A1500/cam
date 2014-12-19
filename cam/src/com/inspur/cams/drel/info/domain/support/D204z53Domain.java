package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204z53Dao;
import com.inspur.cams.drel.info.data.D204z53;
import com.inspur.cams.drel.info.domain.ID204z53Domain;

/**
 * 司法援助信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z53Domain implements ID204z53Domain {

	@Reference
	private ID204z53Dao d204z53Dao;

	/**
	 * 查询 司法援助信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z53Dao.query(pset);
	}

	/**
	 * 获取 司法援助信息
	 * @param pset
	 * @return
	 */
	public D204z53 get(String d204z53Id) {
		return d204z53Dao.get(d204z53Id);
	}

	/**
	 * 增加 司法援助信息
	 * @param d204z53
	 */
	public void insert(D204z53 d204z53) {
		d204z53.setD204z53Id(IdHelp.getUUID32());
		d204z53.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204z53.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204z53.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204z53.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204z53.setInputTime(DateUtil.getTime());
		d204z53Dao.insert(d204z53);
	}
	
	/**
	 * 修改 司法援助信息
	 * @param d204z53
	 */
	public void update(D204z53 d204z53) {
		d204z53Dao.update(d204z53);
	}
	
	/**
	 * 删除 司法援助信息
	 * @param d204z53Id
	 */
	public void delete(String d204z53Id) {
		d204z53Dao.delete(d204z53Id);
	}

}