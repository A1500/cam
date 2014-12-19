package com.inspur.cams.drel.info.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.info.dao.ID204d37Dao;
import com.inspur.cams.drel.info.data.D204d37;
import com.inspur.cams.drel.info.domain.ID204d37Domain;

/**
 * 地税-法人纳税信息domain
 * @author 
 * @date 2014-08-26
 */
public class D204d37Domain implements ID204d37Domain {

	@Reference
	private ID204d37Dao d204d37Dao;

	/**
	 * 查询 地税-法人纳税信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return d204d37Dao.query(pset);
	}

	/**
	 * 获取 地税-法人纳税信息
	 * @param pset
	 * @return
	 */
	public D204d37 get(String d204d37Id) {
		return d204d37Dao.get(d204d37Id);
	}

	/**
	 * 增加 地税-法人纳税信息
	 * @param d204d37
	 */
	public void insert(D204d37 d204d37) {
		d204d37Dao.insert(d204d37);
	}
	
	/**
	 * 修改 地税-法人纳税信息
	 * @param d204d37
	 */
	public void update(D204d37 d204d37) {
		d204d37Dao.update(d204d37);
	}
	
	/**
	 * 删除 地税-法人纳税信息
	 * @param d204d37Id
	 */
	public void delete(String d204d37Id) {
		d204d37Dao.delete(d204d37Id);
	}

}