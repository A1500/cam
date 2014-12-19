package com.inspur.comm.searchhelp.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.searchhelp.data.CommHelp;


/**
 * 通用帮助dao接口
 * @author shgtch
 * @date 2011-6-20
 */
public interface ICommHelpDao {

	/**
	 * 获取通用帮助配置
	 * @param helpId
	 * @return
	 */
	public CommHelp getCommHelp(String helpId);
	
	/**
	 * 增加通用帮助配置
	 * @param commHelp
	 */
	public void insertCommHelp(CommHelp commHelp);
	
	/**
	 * 更新通用帮助配置
	 * @param commHelp
	 */
	public void updateCommHelp(CommHelp commHelp);
	
	/**
	 * 删除通用帮助配置
	 * @param helpId
	 */
	public void deleteCommHelp(String helpId);
	
	/**
	 * 查询通用帮助配置
	 * @param ps
	 * @return
	 */
	public DataSet query(ParameterSet ps);
	
	/**
	 * 获取通用帮助窗口字典集合
	 * @param helpId
	 * @return
	 */
	public DataSet getHelpDataset(ParameterSet ps, CommHelp commHelp);
	
	/**
	 * 获取通用帮助下拉列表字典集合
	 * @param helpId
	 * @return
	 */
	public DataSet getSelectDataset(CommHelp commHelp);
	
	/**
	 * 获取字典解析
	 * @param commHelp
	 * @param key
	 * @return
	 */
	public DataSet getDicValue(CommHelp commHelp, String key);
	
}
