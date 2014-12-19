package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d37;

/**
 * 地税-法人纳税信息domain
 * @author 
 * @date 2014-08-26
 */
public interface ID204d37Domain {

	/**
	 * 查询 地税-法人纳税信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 地税-法人纳税信息
	 * @param pset
	 * @return
	 */
	public D204d37 get(String d204d37Id);

	/**
	 * 增加 地税-法人纳税信息
	 * @param d204d37
	 */
	@Trans
	public void insert(D204d37 d204d37);
	
	/**
	 * 修改 地税-法人纳税信息
	 * @param d204d37
	 */
	@Trans
	public void update(D204d37 d204d37);
	
	/**
	 * 删除 地税-法人纳税信息
	 * @param d204d37Id
	 */
	@Trans
	public void delete(String d204d37Id);

}