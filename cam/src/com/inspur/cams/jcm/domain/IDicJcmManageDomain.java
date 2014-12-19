package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.DicJcmManage;

/**
 * 字典维护domain
 * @author 
 * @date 2014-05-22
 */
public interface IDicJcmManageDomain {

	/**
	 * 查询 字典维护
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 字典维护
	 * @param pset
	 * @return
	 */
	public DicJcmManage get(String dicType);

	/**
	 * 增加 字典维护
	 * @param dicJcmManage
	 */
	@Trans
	public void insert(DicJcmManage dicJcmManage);
	
	/**
	 * 修改 字典维护
	 * @param dicJcmManage
	 */
	@Trans
	public void update(DicJcmManage dicJcmManage);
	
	/**
	 * 删除 字典维护
	 * @param dicType
	 */
	@Trans
	public void delete(String dicType);

}