package com.inspur.cams.drel.mbalance.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.mbalance.data.SamMBalance;




/**
 * @title:ISamMedicalBalanceDao
 * @description:一站式救助Dao接口
 * @author:
 * @since:2011-05-13
 * @version:1.0
*/
 public interface ISamMBalanceDao extends BaseCURD<SamMBalance>{
	public void save(List<SamMBalance> list);
	/**
	 *  查询一站式结算信息
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForSamList(ParameterSet paramSet);
	/**
	 * 一站式结算报表详细信息
	 * @return
	 */
	public DataSet queryForReportDetail(ParameterSet paramSet);
	/**
	 * 根据人员ID查询人员未出院人员信息，用于住院登记校验
	 * @param paramSet
	 * @return
	*/
	public DataSet queryForInCheck(ParameterSet paramSet);
	/**
	 * 查询家庭及个人历史救助费用
	 * @return
	 */
	public DataSet queryForBalanceHistory(ParameterSet paramSet);
	/**
	 * 停助方法
	 * @param paramSet
	 */
	public void stopAssistance(ParameterSet paramSet);
	/**
	 * 一站式结算报表统计查询
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForReport(ParameterSet paramSet);
	/**
	 * 一站式结算报表统计查询-按照一定条件
	 * @param paramSet
	 * @return
	 */
	public DataSet querybuilderList(ParameterSet paramSet);
	/**
	 * 明细查看
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForDetailReport(ParameterSet paramSet);

	/**
	 * 优抚查询（按医院、属地、优抚类别、时间段）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForBpt(ParameterSet paramSet);
	
	/**
	 * 优抚明细查询（按医院、属地、优抚类别、时间段）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryYfDetail(ParameterSet paramSet);
	
	/**
	 * 低保、五保救助对象中，重度残疾（1、2级伤残）、优抚对象、老年人数量和比例统计
	 * @param paramSet
	 * @return
	 */
	
	public DataSet queryBptDisOld(ParameterSet paramSet);

	/**
	 * 按救助对象属地、救助金额区间、时间段统计查询（柱状图展现）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForFlex(ParameterSet paramSet);
	public DataSet queryBalance(String peopleId,String inDate);
	public DataSet queryBalance(String status,String peopleId,String inDate,String hospitalId,String strikeStatus);
}

