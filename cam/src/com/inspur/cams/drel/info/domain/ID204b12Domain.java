package com.inspur.cams.drel.info.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.info.data.D204b12;

/**
 * 经营性收入domain
 * @author 
 * @date 2014-06-09
 */
public interface ID204b12Domain {

	/**
	 * 查询 经营性收入
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 经营性收入
	 * @param pset
	 * @return
	 */
	public D204b12 get(String d204b12Id);

	/**
	 * 增加 经营性收入
	 * @param d204b12
	 */
	@Trans
	public void insert(D204b12 d204b12);
	
	/**
	 * 修改 经营性收入
	 * @param d204b12
	 */
	@Trans
	public void update(D204b12 d204b12);
	
	/**
	 * 删除 经营性收入
	 * @param d204b12Id
	 */
	@Trans
	public void delete(String d204b12Id);
	@Trans
	public void save(List list);
	@Trans
	public DataSet queryGongshang(ParameterSet pset);

}