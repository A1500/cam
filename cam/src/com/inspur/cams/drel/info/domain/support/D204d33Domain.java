package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.drel.info.dao.ID204d33Dao;
import com.inspur.cams.drel.info.data.D204d33;
import com.inspur.cams.drel.info.domain.ID204d33Domain;

/**
 * 纳税情况domain
 * @author 
 * @date 2014-06-09
 */
public class D204d33Domain implements ID204d33Domain {

	@Reference
	private ID204d33Dao d204d33Dao;

	/**
	 * 查询 纳税情况
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d33Dao.query(pset);
	}

	/**
	 * 获取 纳税情况
	 * @param pset
	 * @return
	 */
	public D204d33 get(String d204d33Id) {
		return d204d33Dao.get(d204d33Id);
	}

	/**
	 * 增加 纳税情况
	 * @param d204d33
	 */
	public void insert(D204d33 d204d33) {
	}
	
	/**
	 * 修改 纳税情况
	 * @param d204d33
	 */
	public void update(D204d33 d204d33) {
		d204d33Dao.update(d204d33);
	}
	
	/**
	 * 删除 纳税情况
	 * @param d204d33Id
	 */
	public void delete(String d204d33Id) {
		d204d33Dao.delete(d204d33Id);
	}

	public DataSet queryGuoshui(ParameterSet pset) {
		// TODO Auto-generated method stub
		return d204d33Dao.queryGuoshui(pset);
	}

}