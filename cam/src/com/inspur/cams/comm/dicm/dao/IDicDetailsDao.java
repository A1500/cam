package com.inspur.cams.comm.dicm.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.dicm.data.DicDetails;

/**
 * 字典详细信息dao接口
 * @author luguosui
 * @date 2011-8-31
 */
public interface IDicDetailsDao  extends BaseCURD<DicDetails>{
	public void save(List<DicDetails> list);
	
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
