package com.inspur.sdmz.jzfa.domain.support;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.util.ExtBspInfo;
import com.inspur.sdmz.comm.util.BspUtil;
import com.inspur.sdmz.comm.util.DateUtil;
import com.inspur.sdmz.comm.util.IdHelp;
import com.inspur.sdmz.jtxx.domain.IYgjzJtxxDomain;
import com.inspur.sdmz.jzfa.dao.IComPlanOrganDao;
import com.inspur.sdmz.jzfa.dao.IDetailDao;
import com.inspur.sdmz.jzfa.dao.IPlanDao;
import com.inspur.sdmz.jzfa.data.ComPlanOrgan;
import com.inspur.sdmz.jzfa.data.Detail;
import com.inspur.sdmz.jzfa.data.Plan;
import com.inspur.sdmz.jzfa.domain.IPlanDomain;

/**
 * 救助方案Domain实现类
 * @author shgtch
 * @date 2011-4-16
 */
public class PlanDomain implements IPlanDomain {

	// 救助方案Dao
	@Reference
	private IPlanDao helpDao;
	//救助单位从表（区分民政和外部单位）
	@Reference
	private IComPlanOrganDao comPlanOrganDao;
	
	// 救助方案明细Dao
	@Reference
	private IDetailDao detailDao;
	
	/**
	 * 增加一条救助方案
	 * @param jzfa
	 */
	public void addJzfa(Plan jzfa,HttpServletRequest request,String organType) {
		jzfa.setPlanId(IdHelp.getUUID30());
		if(StringUtils.isNotEmpty(organType)){
			jzfa.setPlanOrgId(ExtBspInfo.getUserInfo(request).getOrganId());
			jzfa.setPlanOrgRegion(ExtBspInfo.getUserInfo(request).getAreaCode());
			jzfa.setRegId(ExtBspInfo.getUserInfo(request).getUserId());
			jzfa.setRegName(ExtBspInfo.getUserInfo(request).getUserName());
			jzfa.setRegOrgID(ExtBspInfo.getUserInfo(request).getOrganId());
			jzfa.setRegOrgName(ExtBspInfo.getUserInfo(request).getAreaName());
			jzfa.setRegOrgRegion(ExtBspInfo.getUserInfo(request).getAreaCode().trim());
			
		}else{
			jzfa.setPlanOrgId(BspUtil.getCorpOrgan().getOrganId());
			jzfa.setPlanOrgRegion(BspUtil.getCorpOrgan().getOrganCode());
			jzfa.setRegId(BspUtil.getEmpOrgan().getOrganId());
			jzfa.setRegName(BspUtil.getEmpOrgan().getOrganName());
			jzfa.setRegOrgID(BspUtil.getCorpOrgan().getOrganId());
			jzfa.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
			jzfa.setRegOrgRegion(BspUtil.getCorpOrgan().getOrganCode());
		}		
		jzfa.setRegTime(DateUtil.getTime());
		jzfa.setStatus("0");
		jzfa.setFund(new BigDecimal("0.00"));
		jzfa.setFamilyNum(new BigDecimal("0"));
		jzfa.setPeopleNum(new BigDecimal("0"));
		helpDao.addJzfa(jzfa);
		
		ComPlanOrgan comPlanOrgan=new ComPlanOrgan();
		comPlanOrgan.setOrganId(jzfa.getRegOrgID());
		comPlanOrgan.setOrganName(jzfa.getRegName());
		if(StringUtils.isNotEmpty(organType)){
			comPlanOrgan.setOrganType(organType);
		}
		comPlanOrgan.setPlanId(jzfa.getPlanId());
		comPlanOrganDao.insert(comPlanOrgan);
	}
	
	/**
	 * 修改一条救助方案
	 * @param jzfa
	 */
	public void updateJzfa(Plan jzfa,HttpServletRequest request,String organType) {
		if("".equals(jzfa.getFamilyNum())||jzfa.getFamilyNum()==null){
			jzfa.setFamilyNum(new BigDecimal("0"));
		}
		if("".equals(jzfa.getPeopleNum())||jzfa.getPeopleNum()==null){
			jzfa.setPeopleNum(new BigDecimal("0"));
		}
		if("".equals(jzfa.getFund())||jzfa.getFund()==null){
			jzfa.setFund(new BigDecimal("0"));
		}
		if(StringUtils.isNotEmpty(organType)){
			jzfa.setModId(ExtBspInfo.getUserInfo(request).getOrganId());
			jzfa.setModName(ExtBspInfo.getUserInfo(request).getOrganName());
			jzfa.setModOrgId(ExtBspInfo.getUserInfo(request).getOrganId());
			jzfa.setModOrgName(ExtBspInfo.getUserInfo(request).getAreaName());
			jzfa.setModOrgRegion(ExtBspInfo.getUserInfo(request).getAreaCode());
		}else{
			jzfa.setModId(BspUtil.getEmpOrgan().getOrganId());
			jzfa.setModName(BspUtil.getEmpOrgan().getOrganName());
			jzfa.setModOrgId(BspUtil.getCorpOrgan().getOrganId());
			jzfa.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
			jzfa.setModOrgRegion(BspUtil.getCorpOrgan().getOrganCode());
		}
		jzfa.setModDate(DateUtil.getTime());
		helpDao.updateJzfa(jzfa);
	}
	
	/**
	 * 删除一条救助方案，并删除相关救助方案明细
	 * @param jzfaid
	 */
	public void deleteJzfa(String jzfaid) {
		detailDao.deleteJzfamxByJzfaid(jzfaid);
		helpDao.deleteJzfa(jzfaid);
		comPlanOrganDao.deleteById(jzfaid);
	}
	
	/**
	 * 查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet jzfaQuery(ParameterSet pset) {
		return helpDao.jzfaQuery(pset);
	}
	
	/**
	 * 查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet queryExt(ParameterSet pset) {
		return helpDao.queryExt(pset);
	}
	
	/**
	 * 增加一条救助方案明细
	 * @param jzfamx
	 */
	public String  addJzfamx(Detail jzfamx,String jzfaid, String sfzh,String szdxlxdm,HttpServletRequest request) {
		String szdxId=getCheckedJtidBysfzh(sfzh);
		if(!"2".equals(szdxlxdm)){
		
		
		if("".equals(szdxId)||szdxId==""){
			
		//	return szdxId;
		}
		}
		
		jzfamx.setPlanId(jzfaid);
		jzfamx.setDetailId(IdHelp.getUUID30());
		String organType="";
		try{
			organType=ExtBspInfo.getUserInfo(request).getOrganType();
		}catch (Exception e) {
			jzfamx.setRegName(BspUtil.getEmpOrgan().getOrganName());
			jzfamx.setRegId(BspUtil.getEmpOrgan().getOrganId());
			jzfamx.setRegOrgName(BspUtil.getCorpOrgan().getOrganName());
			jzfamx.setRegOrgRegion(BspUtil.getCorpOrgan().getOrganCode());
			jzfamx.setRegOrgId(BspUtil.getCorpOrgan().getOrganId());
		}
		if(StringUtils.isNotEmpty(organType)){
			jzfamx.setRegName(ExtBspInfo.getUserInfo(request).getOrganName());
			jzfamx.setRegId(ExtBspInfo.getUserInfo(request).getOrganId());
			jzfamx.setRegOrgName(ExtBspInfo.getUserInfo(request).getOrganName());
			jzfamx.setRegOrgRegion(ExtBspInfo.getUserInfo(request).getAreaCode());
			jzfamx.setRegOrgId(ExtBspInfo.getUserInfo(request).getOrganId());
		}
		jzfamx.setRegTime(DateUtil.getTime());
		
		jzfamx.setAssistedId(szdxId);
		if(jzfamx.getCaptial()==null||jzfamx.getCaptial().equals("")){
			jzfamx.setCaptial(new BigDecimal("0.00"));
		}
		if(jzfamx.getGoodsNums()==null||jzfamx.getGoodsNums().equals("")){
			jzfamx.setGoodsNums(new BigDecimal("0.00"));
		}
		if(jzfamx.getGoodsNum()==null||jzfamx.getGoodsNum().equals("")){
			jzfamx.setGoodsNum(new BigDecimal("0"));
		}
		detailDao.addJzfamx(jzfamx);
		
		helpDao.addJzje(jzfamx,jzfaid);
		
		return szdxId;
	}
	
	/**
	 * 修改一条救助方案明细
	 * @param jzfamx
	 */
	public String updateJzfamx(Detail jzfamx,String jzfaid,String sfzh,String szdxlxdm,HttpServletRequest request) {
		String szdxId=getCheckedJtidBysfzh(sfzh);
		if(!"2".equals(szdxlxdm)){
		
		if("".equals(szdxId)||szdxId==""){
			
		//	return szdxId;
		}
		}else{
			
			jzfamx.setIdCard("");
		}
		String organType="";
		try{
			organType=ExtBspInfo.getUserInfo(request).getOrganType();
		}catch (Exception e) {
			jzfamx.setModId(BspUtil.getEmpOrgan().getOrganId());
			jzfamx.setModName(BspUtil.getEmpOrgan().getOrganName());
			jzfamx.setModOrgId(BspUtil.getCorpOrgan().getOrganId());
			jzfamx.setModOrgName(BspUtil.getCorpOrgan().getOrganName());
			jzfamx.setModOrgRegion(BspUtil.getCorpOrgan().getOrganCode());
		}
		if(StringUtils.isNotEmpty(organType)){
			jzfamx.setModId(ExtBspInfo.getUserInfo(request).getOrganId());
			jzfamx.setModName(ExtBspInfo.getUserInfo(request).getOrganName());
			jzfamx.setModOrgId(ExtBspInfo.getUserInfo(request).getOrganId());
			jzfamx.setModOrgName(ExtBspInfo.getUserInfo(request).getAreaName());
			jzfamx.setModOrgRegion(ExtBspInfo.getUserInfo(request).getAreaCode());
		}
		jzfamx.setModTime(DateUtil.getTime());
		jzfamx.setAssistedId(szdxId);
		if(jzfamx.getCaptial()==null||jzfamx.getCaptial().equals("")){
			jzfamx.setCaptial(new BigDecimal("0.00"));
		}
		if(jzfamx.getGoodsNums()==null||jzfamx.getGoodsNums().equals("")){
			jzfamx.setGoodsNums(new BigDecimal("0.00"));
		}
		if(jzfamx.getGoodsNum()==null||jzfamx.getGoodsNum().equals("")){
			jzfamx.setGoodsNum(new BigDecimal("0"));
		}
		detailDao.updateJzfamx(jzfamx);
		helpDao.addJzje(jzfamx,jzfaid);
		return szdxId;
	}
	
	/**
	 * 删除一条救助方案明细
	 * @param jzfamxid
	 */
	public void deleteJzfamx(String jzfamxid,String jzfaid ) {
		detailDao.deleteJzfamx(jzfamxid);
		Detail jzfamx=new Detail();
		helpDao.addJzje(jzfamx,jzfaid);
		helpDao.addJe(jzfaid);
		
	}
	
	/**
	 * 查询救助方案
	 * @param pset
	 * @return
	 */
	public DataSet jzfamxQuery(ParameterSet pset) {
		return detailDao.jzfamxQuery(pset);
	}
	
	/**
	 * 根据救助方案内码查询救助方案明细
	 * @param jzfaid
	 * @return
	 */
	public DataSet jzfamxQueryByJzfaid(String jzfaid) {
		return detailDao.jzfamxQueryByJzfaid(jzfaid);
	}
	
	/**
	 * 数据统计
	 * @param pset
	 * @return
	 */
	public DataSet sjtj(){
		return helpDao.sjtj();
	}
	
	/**
	 * 已实施方案数据统计
	 * @param pset
	 * @return
	 */
	public DataSet sjtjss(){
		return helpDao.sjtjss();
	}
	
	/**
	 * 救助方案实施
	 * @param pset
	 * @return
	 */
	public void passJzfa(String[] jzfaids){
		
		helpDao.passJzfa(jzfaids);//更新实施状态标志
		
		//实施救助方案后进行计算救助指数的操作 Added by fujw,2011-05-26.
		IYgjzJtxxDomain jtxxService = ScaComponentFactory.getService(
				IYgjzJtxxDomain.class, "YgjzJtxxDomain/YgjzJtxxDomain");//获取家庭信息服务接口
		for(int i=0; i<jzfaids.length; i++) {
			ParameterSet pset = new ParameterSet();
			pset.setParameter("PLAN_ID", jzfaids[i]);
			DataSet ds = this.jzfamxQuery(pset);//根据救助方案ID查询救助方案明细结果集
			for(int j=0; j<ds.getCount(); j++) {
				Record rec = ds.getRecord(j);
				String sfzh = (String)rec.get("idCard");//获取每条救助方案明细记录中的身份证号
				String jtid = this.getCheckedJtidBysfzh(sfzh);//查出对应的家庭ID
//				if(jtid == null || "".equals(jtid)) {
//					throw new BusinessException("不符合救助条件的受助对象，请检查救助方案明细中的受助对象是否已审核通过！受助对象："+rec.get("szdxmc")+"。");
//				}else {
//					jtxxService.countJtxxJzzs(jtid);// 计算并保存救助指数
//				}
				if(jtid != null && !"".equals(jtid)){
					jtxxService.countJtxxJzzs(jtid);// 计算并保存救助指数
				} 
			}
		}	
		
	}
	
	/**
	 * 明细数据统计
	 * @param 
	 * @return
	 */
	//public DataSet sjtjmx(String jzfaid){
	//	return detailDao.sjtjmx(jzfaid);
	//}
	
	/**
	 * 救助方案分析页面数据统计
	 * @param 
	 * @return
	 */
	public DataSet sjtjAnalyze(){
		return helpDao.sjtjAnalyze();
	}
	
	/**
	 * 删除时救助方案明细表中的数据时，对主表中救助金额进行更新
	 * @param 
	 * @return
	 */
	public void delJzje(String jzfamxid){
		helpDao.delJzje(jzfamxid);
	}
	
	/**
	 * 分析饼图页面的返回DataSet方法
	 * @param 
	 * @return
	 */
	public DataSet analyzeJzfa(String jzfaids){
		return helpDao.analyzeJzfa(jzfaids);
	}
	
	/**
	 * 分析饼图页面的数据统计DataSet方法
	 */
	public DataSet analyzeJzfafx(String jzfaids){
		return helpDao.analyzeJzfafx(jzfaids);
	}
	
	/**
	 * 根据身份证号查询审核通过的家庭ID
	 * @param sfzh
	 * @return
	 */
	public String getCheckedJtidBysfzh(String sfzh) {
		return detailDao.getCheckedJtidBysfzh(sfzh);
	}
	
	/**
	 * 查询受助人是否被其他方案救助
	 */
	public String ifAssisted(String idCard){
		if(!"".equals(idCard)){
			ParameterSet pset = new ParameterSet();
			pset.setParameter("ID_CARD@=", idCard);
			DataSet ds = detailDao.jzfamxQuery(pset);
			String num = ""+ ds.getCount();
			return num;
		}else{
			return null;
		}
	}
	/**
	 * 查询受助人在其他救助方案中的信息
	 */
	public DataSet queryOtherAssisted(ParameterSet pset) {
		return detailDao.queryOtherAssisted(pset);
	}
	
	public IPlanDao gethelpDao() {
		return helpDao;
	}

	public void sethelpDao(IPlanDao helpDao) {
		this.helpDao = helpDao;
	}

	public IDetailDao getDetailDao() {
		return detailDao;
	}

	public void setDetailDao(IDetailDao detailDao) {
		this.detailDao = detailDao;
	}
	
}
