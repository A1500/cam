package com.inspur.cams.drel.mbalance.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.mbalance.data.SamMBalance;
import com.inspur.cams.drel.mbalance.data.SamMedicalBefore;

/**
 * 一站式救助domain接口
 * @author luguosui
 *
 */
public interface ISamMBalanceDomain {
	/**
	 * 查询医院一站式结算信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 插入一站式救助信息
	 * @param samMBalance
	 */
	@Trans
	public void insert(SamMBalance samMBalance);
	/**
	 * 更新一站式救助信息
	 * @param samMBalance
	 */
	@Trans
	public void update(SamMBalance samMBalance);
	/**
	 * 保存一站式救助信息
	 * @param list
	 */
	@Trans
	public void save(List<SamMBalance> list,SamMedicalBefore samMedicalBefore,String needConnect);
	
	@Trans
	public void reg(List<SamMBalance> list,SamMedicalBefore samMedicalBefore);
	/**
	 * 根据一个ID数组删除一站式救助记录
	 */
	@Trans
	public void batchDelete(String[] delIds);
	/**
	 * 查询一站式结算信息
	 * @return
	 */
	@Trans
	public DataSet queryForSamList(ParameterSet paramSet);
	/**
	 * 一站式结算报表统计救助信息条数和救助总费用
	 * @return
	 */
	@Trans
	public DataSet queryForReportDetail(ParameterSet paramSet);
	/**
	 * 根据人员ID查询人员未出院人员信息，用于住院登记校验
	 * @param paramSet
	 * @return
	*/
	@Trans
	public DataSet queryForInCheck(ParameterSet paramSet);
	/**
	 * 停助方法
	 * @param paramSet
	 */
	@Trans
	public void stopAssistant(ParameterSet paramSet);
	/**
	 * 一站式结算报表统计查询
	 * @param paramSet
	 * @return
	 */
	@Trans
	public DataSet queryForReport(ParameterSet paramSet);
	/**
	 * 一站式结算报表统计查询-按照一定条件
	 * @param paramSet
	 * @return
	 */
	public DataSet querybuilderList(ParameterSet paramSet);
	

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
	 * 明细查看
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForDetailReport(ParameterSet paramSet);
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
	
	public DataSet getInsuranceDataSet(ParameterSet paramSet);
	
	/**
	 * 查询历史救助费用
	 */
	public DataSet queryForBalanceHistory(ParameterSet paramSet) ;
	/**
	 * 冲账信息保存
	 * @param strikeDataBean 冲账记录
	 * @param dataBean 新纪录
	 */
	@Trans
	public void saveStrike(SamMBalance strikeDataBean, SamMBalance dataBean);
}
