package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisColumnInfo;

/**
 * 页面列描述domain
 * @author 
 * @date 2012-07-16
 */
public interface IFisColumnInfoDomain {

	/**
	 * 查询 页面列描述
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 页面列描述
	 * @param pset
	 * @return
	 */
	public FisColumnInfo get(String columnId);

	/**
	 * 增加 页面列描述
	 * @param fisColumnInfo
	 */
	@Trans
	public void insert(FisColumnInfo fisColumnInfo);
	
	/**
	 * 修改 页面列描述
	 * @param fisColumnInfo
	 */
	@Trans
	public void update(FisColumnInfo fisColumnInfo);
	
	/**
	 * 删除 页面列描述
	 * @param columnId
	 */
	@Trans
	public void delete(String columnId);

}