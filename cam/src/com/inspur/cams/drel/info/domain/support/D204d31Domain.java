package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204d31Dao;
import com.inspur.cams.drel.info.data.D204d31;
import com.inspur.cams.drel.info.domain.ID204d31Domain;

/**
 * 公共事业缴费domain
 * @author 
 * @date 2014-06-09
 */
public class D204d31Domain implements ID204d31Domain {

	@Reference
	private ID204d31Dao d204d31Dao;

	/**
	 * 查询 公共事业缴费
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d31Dao.query(pset);
	}

	/**
	 * 获取 公共事业缴费
	 * @param pset
	 * @return
	 */
	public D204d31 get(String d204d31Id) {
		return d204d31Dao.get(d204d31Id);
	}

	/**
	 * 增加 公共事业缴费
	 * @param d204d31
	 */
	public void insert(D204d31 d204d31) {
		d204d31.setD204d31Id(IdHelp.getUUID32());
		d204d31.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204d31.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204d31.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204d31.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204d31.setInputTime(DateUtil.getTime());
		d204d31Dao.insert(d204d31);
	}
	
	/**
	 * 修改 公共事业缴费
	 * @param d204d31
	 */
	public void update(D204d31 d204d31) {
		d204d31Dao.update(d204d31);
	}
	
	/**
	 * 删除 公共事业缴费
	 * @param d204d31Id
	 */
	public void delete(String d204d31Id) {
		d204d31Dao.delete(d204d31Id);
	}

}