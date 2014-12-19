package com.inspur.sdmz.jzfa.domain;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.sdmz.jzfa.data.Detail;
import com.inspur.sdmz.jzfa.data.Plan;

/**
 * 救助方案Domain接口
 * @author shgtch
 * @date 2011-4-16
 */
public interface IPlanDomain {

	/**
	 * 增加一条救助方案
	 * @param jzfa
	 */
	@Trans
	public void addJzfa(Plan jzfa,HttpServletRequest request,String organType);
	
	/**
	 * 修改一条救助方案
	 * @param jzfa
	 */
	@Trans
	public void updateJzfa(Plan jzfa,HttpServletRequest request,String organType);
	
	/**
	 * 删除一条救助方案，并删除相关救助方案明细
	 * @param jzfaid
	 */
	@Trans
	public void deleteJzfa(String jzfaid);
	
	/**
	 * 查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet jzfaQuery(ParameterSet pset);
	
	public DataSet queryExt(ParameterSet pset);
	/**
	 * 增加一条救助方案明细
	 * @param jzfamx
	 */
	@Trans
	public String addJzfamx(Detail jzfamx,String jzfaid,String sfzh,String szdxlxdm,HttpServletRequest request);
	
	/**
	 * 修改一条救助方案明细
	 * @param jzfamx
	 */
	@Trans
	public String updateJzfamx(Detail jzfamx,String jzfaid,String sfzh,String szdxlxdm,HttpServletRequest request);
	
	/**
	 * 删除一条救助方案明细
	 * @param jzfamxid
	 */
	@Trans
	public void deleteJzfamx(String jzfamxid,String jzfaid);
	
	/**
	 * 查询救助方案明细
	 * @param pset
	 * @return
	 */
	public DataSet jzfamxQuery(ParameterSet pset);
	
	/**
	 * 根据救助方案内码查询救助方案明细
	 * @param jzfaid
	 * @return
	 */
	public DataSet jzfamxQueryByJzfaid(String jzfaid);

	/**
	 * 数据统计
	 * @param
	 * @return
	 */
	public DataSet sjtj();
	
	/**
	 * 已实施方案数据统计
	 * @param pset
	 * @return
	 */
	public DataSet sjtjss();
	
	/**
	 * 救助方案实施
	 * @param jzfaids
	 * @return
	 */
	@Trans
	public void passJzfa(String[] jzfaids);
	
	/**
	 * 明细数据统计
	 * @param 
	 * @return
	 */
	//public DataSet sjtjmx(String jzfaid);
	
	/**
	 * 救助方案分析页面数据统计
	 * @param 
	 * @return
	 */
	public DataSet sjtjAnalyze();
	
	/**
	 * 删除时救助方案明细表中的数据时，对主表中救助金额进行更新
	 * @param 
	 * @return
	 */
	@Trans
	public void delJzje(String jzfamxid);
	
	/**
	 * 分析饼图页面的返回DataSet方法
	 */
	public DataSet analyzeJzfa(String jzfaids);
	
	/**
	 * 分析饼图页面的数据统计DataSet方法
	 */
	public DataSet analyzeJzfafx(String jzfaids);
	
	/**
	 * 根据身份证号查询审核通过的家庭ID
	 * @param sfzh
	 * @return
	 */
	@Trans
	public String getCheckedJtidBysfzh(String sfzh);
	/**
	 * 查询受助人是否被其他方案救助
	 */
	@Trans
	public String ifAssisted(String idCard);
	
	/**
	 * 查询受助人在其他救助方案中的信息
	 * @param pset
	 * @return
	 */
	public DataSet queryOtherAssisted(ParameterSet pset);
}
