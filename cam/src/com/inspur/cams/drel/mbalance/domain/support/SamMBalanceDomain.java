package com.inspur.cams.drel.mbalance.domain.support;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.edb.core.Logger;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.drel.mbalance.dao.ISamMBalanceDao;
import com.inspur.cams.drel.mbalance.data.SamMBalance;
import com.inspur.cams.drel.mbalance.data.SamMedicalBefore;
import com.inspur.cams.drel.mbalance.data.SamMedicalDetailExpense;
import com.inspur.cams.drel.mbalance.domain.ISamInsuranceDomain;
import com.inspur.cams.drel.mbalance.domain.ISamMBalanceDomain;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalBeforeDomain;
import com.inspur.cams.drel.mbalance.domain.ISamMedicalDetailExpenseDomain;
import com.inspur.cams.drel.mbalance.util.BalanceConfig;
/**
 * 医院一站式救助domain
 * @author luguosui
 *
 */
public class SamMBalanceDomain implements ISamMBalanceDomain {
	@Reference
	private ISamMBalanceDao samMBalanceDao;	
	//费用明细
	@Reference
	private ISamMedicalDetailExpenseDomain detailExpenseDomain;
	//医保、新农合
	@Reference
	private ISamInsuranceDomain insuranceDomain;
	//医前救助
	@Reference
	private ISamMedicalBeforeDomain samMedicalBeforeDomain;
	
	private Log logger = LogFactory.getLog(getClass());
	/**
	 * 插入一站式救助信息
	 */
	public void insert(SamMBalance samMBalance) {
		samMBalanceDao.insert(samMBalance);
	}
	/**
	 * 查询一站式救助信息
	 */
	public DataSet query(ParameterSet pset) {
		return samMBalanceDao.query(pset);
	}

	public void update(SamMBalance samMBalance) {
		samMBalanceDao.update(samMBalance);
	}
	/**
	 * 保存一站式救助信息
	 */
	public void save(List<SamMBalance> list,SamMedicalBefore samMedicalBefore,String needConnect) {
		final SamMBalance samMBalance = list.get(0);
		if("true".equals(needConnect)){
			new Thread(new Runnable(){
				public void run() {
					logger.debug("保存住院花费明细线程,医疗证号："+samMBalance.getMedicalCode()+",入院日期："+samMBalance.getInDate());
					detailExpenseDomain.save(getExpenseDetail(samMBalance));					
				}}).start();	
		}
		if(samMedicalBefore!=null){
			samMedicalBeforeDomain.update(samMedicalBefore);
		}
		samMBalanceDao.save(list);
	}
	/**
	 * 保存一站式救助信息
	 */
	public void reg(List<SamMBalance> list,SamMedicalBefore samMedicalBefore) {
		if(samMedicalBefore!=null){
			samMedicalBeforeDomain.update(samMedicalBefore);
		}
		samMBalanceDao.save(list);
	}
	
	private List getExpenseDetail(SamMBalance samMBalance){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("queryType" ,  "EXPENSE");
		pset.setParameter("organArea",  samMBalance.getHospitalArea());
		pset.setParameter("insuranceType",  samMBalance.getInsuranceType());
		pset.setParameter("insuranceCode" , samMBalance.getMedicalCode());
		pset.setParameter("inDate" , samMBalance.getInDate());
		DataSet dataSet = insuranceDomain.getInsuranceDataSet(pset);
		List detailList = new ArrayList();
		for(int i=0;i<dataSet.getTotalCount();i++){
			Record record = dataSet.getRecord(i);
			SamMedicalDetailExpense detail = (SamMedicalDetailExpense)record.toBean(SamMedicalDetailExpense.class);
			detail.setBalanceId(samMBalance.getBalanceId());
			detail.setExpenseid(com.inspur.cams.comm.util.IdHelp.getUUID32());
			detail.setCode((String)record.get("CODE"));
			detail.setExpDate((String)record.get("EXP_DATE"));
			if(!"".equals(StrUtil.n2b((String)record.get("EXP_MONEY")))){
				detail.setExpMoney(new BigDecimal((String)record.get("EXP_MONEY")));
			}
			detail.setExpName((String)record.get("EXP_NAME"));
			detail.setForm((String)record.get("FORM"));
			if(!"".equals(StrUtil.n2b((String)record.get("NUM")))){
				detail.setNum(new BigDecimal((String)record.get("NUM")));
			}
			
			if(!"".equals(StrUtil.n2b((String)record.get("PRICE")))){
				detail.setPrice(new BigDecimal((String)record.get("PRICE")));
			}
			detail.setType((String)record.get("TYPE"));
			detail.setState(0);
			detailList.add(detail);
		}
		return detailList;
	}
	/**
	 * 根据一个ID数组删除一站式救助记录
	 */
	public void batchDelete(String[] delIds) {
		samMBalanceDao.batchDelete(delIds);
	}
	/**
	 * 查询一站式结算信息
	 * @return
	 */
	public DataSet queryForSamList(ParameterSet paramSet) {
		return samMBalanceDao.queryForSamList(paramSet);
	}
	/**
	 * 一站式结算报表统计救助信息条数和救助总费用
	 * @return
	 */
	public DataSet queryForReportDetail(ParameterSet paramSet) {
		return samMBalanceDao.queryForReport(paramSet);
	}
	/**
	 * 根据人员ID查询人员未出院人员信息，用于住院登记校验
	 * @param paramSet
	 * @return
	*/
	public DataSet queryForInCheck(ParameterSet paramSet){
		return samMBalanceDao.queryForInCheck(paramSet);
	}
	/**
	 * 停助方法
	 */
	public void stopAssistant(ParameterSet paramSet) {
		samMBalanceDao.stopAssistance(paramSet);
	}
	/**
	 * 一站式结算报表统计查询
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForReport(ParameterSet paramSet) {
		return samMBalanceDao.queryForReport(paramSet);
	}
	/**
	 * 一站式结算报表统计查询-按照一定条件
	 * @param paramSet
	 * @return
	 */
	public DataSet querybuilderList(ParameterSet paramSet){
		return samMBalanceDao.querybuilderList(paramSet);
	}

	/**
	 * 优抚查询（按医院、属地、优抚类别、时间段）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForBpt(ParameterSet paramSet){
		return samMBalanceDao.queryForBpt(paramSet);
	}
	/**
	 * 优抚明细查询（按医院、属地、优抚类别、时间段）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryYfDetail(ParameterSet paramSet){
		return samMBalanceDao.queryYfDetail(paramSet);
	}
	/**
	 * 明细查看
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForDetailReport(ParameterSet paramSet){
		return samMBalanceDao.queryForDetailReport(paramSet);
	}
	/**
	 * 低保、五保救助对象中，重度残疾（1、2级伤残）、优抚对象、老年人数量和比例统计
	 * @param paramSet
	 * @return
	 */
	public DataSet queryBptDisOld(ParameterSet paramSet){
		return samMBalanceDao.queryBptDisOld(paramSet);
	}

	/**
	 * 按救助对象属地、救助金额区间、时间段统计查询（柱状图展现）
	 * @param paramSet
	 * @return
	 */
	public DataSet queryForFlex(ParameterSet paramSet){
		return samMBalanceDao.queryForFlex(paramSet);
	}
	
	public DataSet getInsuranceDataSet(ParameterSet paramSet){
		return insuranceDomain.getInsuranceDataSet(paramSet);
	}
	/**
	 * @return the samMedicalBeforeDomain
	 */
	public ISamMedicalBeforeDomain getSamMedicalBeforeDomain() {
		return samMedicalBeforeDomain;
	}
	/**
	 * @param samMedicalBeforeDomain the samMedicalBeforeDomain to set
	 */
	public void setSamMedicalBeforeDomain(ISamMedicalBeforeDomain samMedicalBeforeDomain) {
		this.samMedicalBeforeDomain = samMedicalBeforeDomain;
	}
	public DataSet queryForBalanceHistory(ParameterSet paramSet) {
		return samMBalanceDao.queryForBalanceHistory(paramSet);
	}
	/**
	 * 冲账信息保存
	 * @param strikeDataBean 冲账记录
	 * @param dataBean 新纪录
	 */
	public void saveStrike(SamMBalance strikeDataBean, SamMBalance dataBean) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("BALANCE_ID@=",strikeDataBean.getBalanceId());
		DataSet ds = query(pset);
		if(ds.getCount() == 1){
			//数据库里正常的数据
			SamMBalance trueDataBean=(SamMBalance)ds.getRecord(0).toBean(SamMBalance.class);
			trueDataBean.setModTime(DateUtil.getTime());
			trueDataBean.setStrikeStatus("01");
			update(trueDataBean);//更新
			
			SamMBalance _StrikeDataBean = trueDataBean;
			_StrikeDataBean.setBalanceId(IdHelp.getUUID32());
			_StrikeDataBean.setStrikeBalanceId(trueDataBean.getBalanceId());
			_StrikeDataBean.setStrikeStatus("02");
			_StrikeDataBean.setTotalExpense(-1*trueDataBean.getTotalExpense());
			_StrikeDataBean.setInsuranceExpense(-1*trueDataBean.getInsuranceExpense());
			_StrikeDataBean.setInsurancePay(-1*trueDataBean.getInsurancePay());
			_StrikeDataBean.setOtherPay(-1*trueDataBean.getOtherPay());
			_StrikeDataBean.setHospitalPay(-1*trueDataBean.getHospitalPay());
			_StrikeDataBean.setAssitancePay(-1*trueDataBean.getAssitancePay());
			_StrikeDataBean.setSpecialPay(-1*trueDataBean.getSpecialPay());
			_StrikeDataBean.setPersonalPay(-1*trueDataBean.getPersonalPay());
			_StrikeDataBean.setRegTime(DateUtil.getTime());
			_StrikeDataBean.setModTime("");//清空修改时间
			
			insert(_StrikeDataBean);//插入冲账记录
			
			insert(dataBean);//插入新记录
			
		}else{
			throw new RuntimeException("数据有误！");
		}
	}
}
