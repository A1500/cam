package com.inspur.cams.drel.info.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204d35;

/**
 * 大病支出domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204d35Domain {

	/**
	 * 查询 大病支出
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 大病支出
	 * @param pset
	 * @return
	 */
	public D204d35 get(String d204d35Id);

	/**
	 * 增加 大病支出
	 * @param d204d35
	 */
	@Trans
	public void insert(D204d35 d204d35);
	
	/**
	 * 修改 大病支出
	 * @param d204d35
	 */
	@Trans
	public void update(D204d35 d204d35);
	
	/**
	 * 删除 大病支出
	 * @param d204d35Id
	 */
	@Trans
	public void delete(String d204d35Id);

}