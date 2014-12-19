package com.inspur.sdmz.jzfa.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.sdmz.jzfa.data.Plan;
import com.inspur.sdmz.jzfa.data.Detail;

/**
 * 救助方案Dao接口
 * @author shgtch
 * @date 2011-4-16
 */
public interface IPlanDao {

	/**
	 * 增加一条救助方案
	 * @param jzfa
	 */
	public void addJzfa(Plan jzfa);
	
	/**
	 * 修改一条救助方案
	 * @param jzfa
	 */
	public void updateJzfa(Plan jzfa);
	
	/**
	 * 删除一条救助方案
	 * @param jzfaid
	 */
	public void deleteJzfa(String jzfaid);
	
	/**
	 * 查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet jzfaQuery(ParameterSet pset);
	
	/**
	 * 外部单位查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet queryExt(ParameterSet pset);
	
	/**
	 * 数据统计
	 * @param
	 * @return
	 */
	public DataSet sjtj();
	
	/**
	 * 以实施方案数据统计
	 * @param
	 * @return
	 */
	public DataSet sjtjss();
	
	/**
	 * 分析页面数据统计
	 * @param
	 * @return
	 */
	public DataSet sjtjAnalyze();
	
	/**
	 * 救助方案实施
	 * @param pset
	 * @return
	 */
	public void passJzfa(String[] jzfaids);
	
	/**
	 * 更新主表中的救助金额等
	 * @param jzfamx,jzfaid
	 * @return
	 */
	public void addJzje(Detail jzfamx,String jzfaid);
	
	/**
	 * 更新主表中的救助金额等
	 * @param jzfamx
	 * @return
	 */
	public void updateJzje(Detail jzfamx);
	
	/**
	 * 更新主表中的救助金额等
	 * @param jzfamxid
	 * @return
	 */
	public void delJzje(String jzfamxid);
	
	/**
	 * 分析饼图页面的返回DataSet方法
	 * @param 
	 * @return
	 */
	public DataSet analyzeJzfa(String jzfaids);
	
	/**
	 * 分析饼图页面的返回DataSet方法
	 * @param 
	 * @return
	 */
	public DataSet analyzeJzfafx(String jzfaids);
	/**
	 * 检查数据库合计金额的值 如果为空则赋值0
	 * @param 
	 * @return
	 */
	public void addJe(String jzfaid);
}
