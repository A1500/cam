package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisResourceExtend;

/**
 * 墓位特征扩展表domain
 * @author 
 * @date Fri Apr 13 09:45:56 GMT+08:00 2012
 */
public interface IFisResourceExtendDomain {

	/**
	 * 查询 墓位特征扩展表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 墓位特征扩展表
	 * @param pset
	 * @return
	 */
	public FisResourceExtend get(String recordId);

	/**
	 * 增加 墓位特征扩展表
	 * @param fisResourceExtend
	 */
	@Trans
	public void insert(FisResourceExtend fisResourceExtend);
	
	/**
	 * 修改 墓位特征扩展表
	 * @param fisResourceExtend
	 */
	@Trans
	public void update(FisResourceExtend fisResourceExtend);
	
	/**
	 * 删除 墓位特征扩展表
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);

}