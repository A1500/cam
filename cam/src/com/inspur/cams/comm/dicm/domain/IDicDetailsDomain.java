package com.inspur.cams.comm.dicm.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.dicm.data.DicDetails;


/**
 * 字典详细信息domain接口
 * @author luguosui
 * @date 2011-8-31
 */
public interface IDicDetailsDomain {
	
	/**
	 * 字典详细信息查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 字典详细信息插入
	 * @param dicDetails
	 */
	public void insert(DicDetails dicDetails);
	
	/**
	 * 字典详细信息维护
	 * @param list
	 */
	public void save(List<DicDetails> list);
	
	/**
	 * 字典详细信息更新
	 * @param dicdetails
	 */
	public void update(DicDetails dicDetails);
	

	/**
	 * 页面显示字典表时调用查询方法
	 * @param pset
	 * @return
	 */
	public DataSet queryForDic(ParameterSet pset);

	/**
	 * 页面显示字典表时调用查询方法（通用）
	 * @param pset
	 * @return
	 */
	public DataSet queryForGeneralDic(ParameterSet pset);
}
