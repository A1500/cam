package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisPageInfo;

/**
 * 页面信息表domain
 * @author 
 * @date 2012-07-16
 */
public interface IFisPageInfoDomain {

	/**
	 * 查询 页面信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 页面信息表
	 * @param pset
	 * @return
	 */
	public FisPageInfo get(String pageId);

	/**
	 * 增加 页面信息表
	 * @param fisPageInfo
	 */
	@Trans
	public void insert(FisPageInfo fisPageInfo);
	
	/**
	 * 修改 页面信息表
	 * @param fisPageInfo
	 */
	@Trans
	public void update(FisPageInfo fisPageInfo);
	
	/**
	 * 删除 页面信息表
	 * @param pageId
	 */
	@Trans
	public void delete(String pageId);

}