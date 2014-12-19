package com.inspur.cams.comm.dicm.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.dicm.data.DicManage;


/***
 * 字典信息维护domain接口
 * @author luguosui
 * @date 2011-8-31
 */
public interface IDicManageDomain {
	
	/**
	 * 字典详细信息查询
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 字典详细信息插入
	 * @param dicManage
	 */
	public void insert(DicManage dicManage);
	
	/**
	 * 字典详细信息保存
	 * @param dicManage
	 */
	public void save(List<DicManage> list);
	
	/**
	 * 字典详细信息更新
	 * @param dicManage
	 */
	public void update(DicManage dicManage);
}
