package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisCemeExpendInfo;

/**
 * 公墓扩建表domain
 * @author 
 * @date 2013-09-29
 */
public interface IFisCemeExpendInfoDomain {

	/**
	 * 查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取
	 * @param pset
	 * @return
	 */
	public FisCemeExpendInfo get(String recordId);

	/**
	 * 增加
	 * @param fisCemeExpendInfo
	 */
	@Trans
	public void insert(FisCemeExpendInfo fisCemeExpendInfo);
	
	/**
	 * 修改
	 * @param fisCemeExpendInfo
	 */
	@Trans
	public void update(FisCemeExpendInfo fisCemeExpendInfo);
	
	/**
	 * 删除
	 * @param recordId
	 */
	@Trans
	public void delete(String recordId);

}