package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204z60Dao;
import com.inspur.cams.drel.info.data.D204z60;
import com.inspur.cams.drel.info.domain.ID204z60Domain;

/**
 * 第三方支付信息domain
 * @author 
 * @date 2014-06-09
 */
public class D204z60Domain implements ID204z60Domain {

	@Reference
	private ID204z60Dao d204z60Dao;

	/**
	 * 查询 第三方支付信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204z60Dao.query(pset);
	}

	/**
	 * 获取 第三方支付信息
	 * @param pset
	 * @return
	 */
	public D204z60 get(String d204z60Id) {
		return d204z60Dao.get(d204z60Id);
	}

	/**
	 * 增加 第三方支付信息
	 * @param d204z60
	 */
	public void insert(D204z60 d204z60) {
		d204z60.setD204z60Id(IdHelp.getUUID32());
		d204z60.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204z60.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204z60.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204z60.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204z60.setInputTime(DateUtil.getTime());
		d204z60Dao.insert(d204z60);
	}
	
	/**
	 * 修改 第三方支付信息
	 * @param d204z60
	 */
	public void update(D204z60 d204z60) {
		d204z60Dao.update(d204z60);
	}
	
	/**
	 * 删除 第三方支付信息
	 * @param d204z60Id
	 */
	public void delete(String d204z60Id) {
		d204z60Dao.delete(d204z60Id);
	}

}