package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.comm.util.BspExtUtil;
import com.inspur.cams.drel.info.dao.ID204d35Dao;
import com.inspur.cams.drel.info.data.D204d35;
import com.inspur.cams.drel.info.domain.ID204d35Domain;

/**
 * 大病支出domain
 * @author 
 * @date 2014-06-09
 */
public class D204d35Domain implements ID204d35Domain {

	@Reference
	private ID204d35Dao d204d35Dao;

	/**
	 * 查询 大病支出
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d35Dao.query(pset);
	}

	/**
	 * 获取 大病支出
	 * @param pset
	 * @return
	 */
	public D204d35 get(String d204d35Id) {
		return d204d35Dao.get(d204d35Id);
	}

	/**
	 * 增加 大病支出
	 * @param d204d35
	 */
	public void insert(D204d35 d204d35) {
		d204d35.setD204d35Id(IdHelp.getUUID32());
		d204d35.setInputOrgan(BspExtUtil.getBelongOrganName());
		d204d35.setInputOrganId(BspExtUtil.getBelongOrganId());
		d204d35.setInputPeople(BspUtil.getEmpOrgan().getOrganName());
		d204d35.setInputPeopleId(BspUtil.getEmpOrgan().getOrganId());
		d204d35.setInputTime(DateUtil.getTime());
		d204d35Dao.insert(d204d35);
	}
	
	/**
	 * 修改 大病支出
	 * @param d204d35
	 */
	public void update(D204d35 d204d35) {
		d204d35Dao.update(d204d35);
	}
	
	/**
	 * 删除 大病支出
	 * @param d204d35Id
	 */
	public void delete(String d204d35Id) {
		d204d35Dao.delete(d204d35Id);
	}

}