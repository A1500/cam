package com.inspur.cams.comm.extuser.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.extuser.data.ComExtPath;

/**
 * 扩展页面路径配置dao接口
 * @author shgtch
 * @date 2011-6-29
 */
public interface IComExtPathDao {

	/**
	 * 获取扩展页面路径配置
	 * @param extPath
	 * @return
	 */
	public ComExtPath getComExtPath(String extPath);
	
	/**
	 * 增加扩展页面路径配置
	 * @param comExtPath
	 */
	public void insertComExtPath(ComExtPath comExtPath);
	
	/**
	 * 更新扩展页面路径配置
	 * @param comExtPath
	 */
	public void updateComExtPath(ComExtPath comExtPath);
	
	/**
	 * 删除扩展页面路径配置
	 * @param extPath
	 */
	public void deleteComExtPath(String extPath);

	/**
	 * 查询扩展页面路径配置
	 * @param ps
	 * @return
	 */
	public DataSet queryExtPath(ParameterSet ps);
	
}
