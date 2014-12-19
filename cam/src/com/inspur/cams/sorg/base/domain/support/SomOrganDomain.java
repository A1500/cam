package com.inspur.cams.sorg.base.domain.support;

import java.math.BigDecimal;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.sorg.base.dao.ISomOrganDao;
import com.inspur.cams.sorg.base.dao.ISomOrganHisDao;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.base.data.SomOrganHis;
import com.inspur.cams.sorg.base.domain.ISomOrganDomain;

/**
 * 社会组织domain实现类
 * @author jiangzhaobao
 * @date 2011年6月14日10:33:22
 */
public class SomOrganDomain implements ISomOrganDomain {
	
	@Reference(name="somOrganDao")
	private ISomOrganDao dao;
	
	@Reference(name="somOrganHisDao")
	private ISomOrganHisDao somOrganHisDao;

	/**
	 * 查询社会组织信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dao.query(pset);
	}

	/**
	 * 增加社会组织信息
	 * @param dataBean
	 */
	@Trans
	public void insert(SomOrgan dataBean) {
		dao.insert(dataBean);
	}
	/**
	 * 更新社会组织信息
	 * @param dataBean
	 */
	@Trans
	public void update(SomOrgan dataBean) {
		dao.update(dataBean);
	}
	/**
	 * 批量增加社会组织信息
	 * @param dataBean
	 */
	public void batchInsert(List<SomOrgan> lists) {
		dao.batchInsert(lists);
	}
	/**
	 * 批量更新社会组织信息
	 * @param dataBean
	 */
	public void batchUpdate(List<SomOrgan> lists) {
		dao.batchUpdate(lists);
	}
	/**
	 * 更新社会组织中的党建字段
	 */
	public void updateRegPartyById(String sorgId,String status){
		dao.updateRegPartyById(sorgId,status);
	}
	/**
	 * 更新换届选举日期
	 */
	public void updateElectionDate(String sorgId,String electionDate,Integer electionPriod){
		dao.updateElectionDate(sorgId, electionDate, electionPriod);
	}
	
	/**
	 * 社会组织查询
	 * @param pset
	 * @return
	 */
	public DataSet queryOrgan(ParameterSet pset) {
		return dao.query(pset);
	}
	
	/**
	 * 主体基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMain(ParameterSet pset) {
		pset.setParameter("IF_BRANCH@=", "0");
		return queryOrgan(pset);
	}
	
	/**
	 * 分支基本信息的查询操作
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryBranch(ParameterSet pset) {
		pset.setParameter("IF_BRANCH@=", "1");
		DataSet ds = queryOrgan(pset);
		if (ds.getCount() > 0) {
			for (int i = 0; i < ds.getCount(); i++) {
				Record record = ds.getRecord(i);
				ParameterSet p = new ParameterSet();
				p.setParameter("SORG_ID@=", record.get("mainSorgId"));
				record.set("name", queryMain(p).getRecord(0).get("cnName"));
			}
		}
		return ds;
	}
	
	/**
	 * 分支基本信息的综合查询
	 * 
	 * @param pset
	 * @return DataSet
	 */
	public DataSet totalQueryBranch(ParameterSet pset){
		return dao.totalQueryBranch(pset);
	}
	
	/**
	 * 查询社会组织名称是否重复
	 */
	public String cnNameUK(ParameterSet pset) {
		return ("" + queryOrgan(pset).getCount());
	}
	
	/**
	 * 查询登记证号是否重复
	 */
	public String sorgCodeUK(ParameterSet pset) {
		return ("" + queryOrgan(pset).getCount());
	}
	
	/**
	 * 查询主体对应的未注销分支机构状态的数量
	 */
	public String branchStatusNum(String mainMorgId) {
		ParameterSet pset = new ParameterSet();
		pset.setParameter("MAIN_SORG_ID@=", mainMorgId);
		pset.setParameter("SORG_STATUS@IN", "22,30,31");
		DataSet ds = this.query(pset);
		int num = ds.getCount();
		return ("" + num);
	}

	/**
	 * 查询社会组织名称
	 * 
	 * @param pset
	 * @return String
	 */
	public String queryOrganName(ParameterSet pset){
		String cnName=(String) queryOrgan(pset).getRecord(0).get("cnName");
		return cnName;
	}
	/**
	 * 查询社会组织名称和登记证号
	 * 
	 * @param pset
	 * @return String
	 */
	public Record queryOrganNameAndSorgCode(ParameterSet pset){
		Record record= queryOrgan(pset).getRecord(0);
		return record;
	}
	
	/**
	 * 查询社会组织名称相似
	 */
	public String cnNameSame(ParameterSet pset) {
		return ("" + queryOrgan(pset).getCount());
	}
	
	/**
	 * 增加社会组织信息并保存历史记录
	 * @param dataBean
	 */
	@Trans
	public void insertAndBuildHis(SomOrgan dataBean,String taskCode) {
		dao.insert(dataBean);
		//插入历史表
		SomOrganHis somOrganHis = new SomOrganHis();
		somOrganHis = getHisFromOrgan(dataBean,somOrganHis);
		somOrganHis.setId(IdHelp.getUUID32());
		somOrganHis.setTaskCode(taskCode);
		somOrganHisDao.insert(somOrganHis);
	}
	
	@Trans
	public void updateAndBuildHis(SomOrgan dataBean,String taskCode) {
		dao.update(dataBean);
		ParameterSet pset = new ParameterSet();
		pset.setParameter("TASK_CODE@=", taskCode);
		DataSet ds = somOrganHisDao.query(pset);
		//如果存在一条，根据organ的bean赋值，然后更新
		if(ds.getCount() == 1){
			SomOrganHis somOrganHis = (SomOrganHis) ds.getRecord(0).toBean(SomOrganHis.class);
			somOrganHis = getHisFromOrgan(dataBean,somOrganHis);
			somOrganHisDao.update(somOrganHis);
		}
		if(ds.getCount() == 0){
			SomOrganHis somOrganHis = new SomOrganHis();
			somOrganHis  = getHisFromOrgan(dataBean,somOrganHis);
			somOrganHis.setId(IdHelp.getUUID32());
			somOrganHis.setTaskCode(taskCode);
			somOrganHisDao.insert(somOrganHis);
		}
	}
	
	/**
	 * 将SomOrgan的bean转化为SomOrganHis的bean
	 * @param dataBean
	 * @return
	 */
	public SomOrganHis getHisFromOrgan(SomOrgan dataBean,SomOrganHis SomOrganHis){
		SomOrganHis.setSorgId(StrUtil.n2b(dataBean.getSorgId()));
		SomOrganHis.setSorgStatus(StrUtil.n2b(dataBean.getSorgStatus()));
		SomOrganHis.setSorgType(StrUtil.n2b(dataBean.getSorgType()));
		SomOrganHis.setIfBranch(StrUtil.n2b(dataBean.getIfBranch()));
		SomOrganHis.setMainSorgId(StrUtil.n2b(dataBean.getMainSorgId()));
		SomOrganHis.setMainSorgCode(StrUtil.n2b(dataBean.getMainSorgCode()));
		SomOrganHis.setSorgKind(StrUtil.n2b(dataBean.getSorgKind()));
		SomOrganHis.setOrganCode(StrUtil.n2b(dataBean.getOrganCode()));
		SomOrganHis.setSorgCode(StrUtil.n2b(dataBean.getSorgCode()));
		SomOrganHis.setCnName(StrUtil.n2b(dataBean.getCnName()));
		SomOrganHis.setEnName(StrUtil.n2b(dataBean.getEnName()));
		SomOrganHis.setAbName(StrUtil.n2b(dataBean.getAbName()));
		SomOrganHis.setSorgPhone(StrUtil.n2b(dataBean.getSorgPhone()));
		SomOrganHis.setSorgFax(StrUtil.n2b(dataBean.getSorgFax()));
		SomOrganHis.setSorgPost(StrUtil.n2b(dataBean.getSorgPost()));
		SomOrganHis.setSorgAdds(StrUtil.n2b(dataBean.getSorgAdds()));
		SomOrganHis.setSorgWeb(StrUtil.n2b(dataBean.getSorgWeb()));
		SomOrganHis.setSorgEmail(StrUtil.n2b(dataBean.getSorgEmail()));
		SomOrganHis.setPurpose(StrUtil.n2b(dataBean.getPurpose()));
		SomOrganHis.setBusiness(StrUtil.n2b(dataBean.getBusiness()));
		SomOrganHis.setBusinessCode(StrUtil.n2b(dataBean.getBusinessCode()));
		SomOrganHis.setBusScope(StrUtil.n2b(dataBean.getBusScope()));
		SomOrganHis.setBorgName(StrUtil.n2b(dataBean.getBorgName()));
		SomOrganHis.setActArea(StrUtil.n2b(dataBean.getActArea()));
		SomOrganHis.setResideSource(StrUtil.n2b(dataBean.getResideSource()));
		SomOrganHis.setResidence(StrUtil.n2b(dataBean.getResidence()));
		SomOrganHis.setHousingOrgan(StrUtil.n2b(dataBean.getHousingOrgan()));
		SomOrganHis.setHousingArea(numFormat(dataBean.getHousingArea()));
		SomOrganHis.setLeasePeriod(StrUtil.n2b(dataBean.getLeasePeriod()));
		SomOrganHis.setFundingPeople(StrUtil.n2b(dataBean.getFundingPeople()));
		SomOrganHis.setRegMon(StrUtil.n2b(dataBean.getRegMon()));
		SomOrganHis.setCurrency(StrUtil.n2b(dataBean.getCurrency()));
		SomOrganHis.setCheckCapitalOrgan(StrUtil.n2b(dataBean.getCheckCapitalOrgan()));
		SomOrganHis.setMoneySource(StrUtil.n2b(dataBean.getMoneySource()));
		SomOrganHis.setBuildStatus(StrUtil.n2b(dataBean.getBuildStatus()));
		SomOrganHis.setAbsorpMember(StrUtil.n2b(dataBean.getAbsorpMember()));
		SomOrganHis.setFacilities(StrUtil.n2b(dataBean.getFacilities()));
		SomOrganHis.setUnitsNum(numFormat(dataBean.getUnitsNum()));
		SomOrganHis.setPeopleNum(numFormat(dataBean.getPeopleNum()));
		SomOrganHis.setCouncilNum(numFormat(dataBean.getCouncilNum()));
		SomOrganHis.setStandCouncilNum(numFormat(dataBean.getStandCouncilNum()));
		SomOrganHis.setMemberNum(numFormat(dataBean.getMemberNum()));
		SomOrganHis.setEngagedNum(numFormat(dataBean.getEngagedNum()));
		SomOrganHis.setPracticeNum(numFormat(dataBean.getPracticeNum()));
		SomOrganHis.setCheckYear(StrUtil.n2b(dataBean.getCheckYear()));
		SomOrganHis.setBuildDate(StrUtil.n2b(dataBean.getBuildDate()));
		SomOrganHis.setRegDate(StrUtil.n2b(dataBean.getRegDate()));
		SomOrganHis.setCancelReasonDesc(StrUtil.n2b(dataBean.getCancelReasonDesc()));
		SomOrganHis.setCancelReason(StrUtil.n2b(dataBean.getCancelReason()));
		SomOrganHis.setCancelDate(StrUtil.n2b(dataBean.getCancelDate()));
		SomOrganHis.setLiqResult(StrUtil.n2b(dataBean.getLiqResult()));
		SomOrganHis.setCredit(StrUtil.n2b(dataBean.getCredit()));
		SomOrganHis.setMorgName(StrUtil.n2b(dataBean.getMorgName()));
		SomOrganHis.setMorgArea(StrUtil.n2b(dataBean.getMorgArea()));
		SomOrganHis.setLegalPeople(StrUtil.n2b(dataBean.getLegalPeople()));
		SomOrganHis.setMainSorgName(StrUtil.n2b(dataBean.getMainSorgName()));
		SomOrganHis.setBranchCharger(StrUtil.n2b(dataBean.getBranchCharger()));
		SomOrganHis.setBorgPhone(StrUtil.n2b(dataBean.getBorgPhone()));
		SomOrganHis.setBorgPeople(StrUtil.n2b(dataBean.getBorgPeople()));
		SomOrganHis.setAppReason(StrUtil.n2b(dataBean.getAppReason()));
		SomOrganHis.setBusinessForPrint(StrUtil.n2b(dataBean.getBusinessForPrint()));
		//维护历史表中联系人与联系电话
		SomOrganHis.setSorgPeople(StrUtil.n2b(dataBean.getSorgPeople()));
		SomOrganHis.setSorgPeoplePhone(StrUtil.n2b(dataBean.getSorgPeoplePhone()));
		
		return SomOrganHis;
	}
	
	/**
	 * 将SomOrganHis的bean转化为SomOrgan的bean
	 * @param dataBean
	 * @return
	 */
	public SomOrgan getOrganFromHis(SomOrgan dataBean,SomOrganHis SomOrganHis){
		dataBean.setSorgId(StrUtil.n2b(SomOrganHis.getSorgId()));
		dataBean.setSorgStatus(StrUtil.n2b(SomOrganHis.getSorgStatus()));
		dataBean.setSorgType(StrUtil.n2b(SomOrganHis.getSorgType()));
		dataBean.setIfBranch(StrUtil.n2b(SomOrganHis.getIfBranch()));
		dataBean.setMainSorgId(StrUtil.n2b(SomOrganHis.getMainSorgId()));
		dataBean.setMainSorgCode(StrUtil.n2b(SomOrganHis.getMainSorgCode()));
		dataBean.setSorgKind(StrUtil.n2b(SomOrganHis.getSorgKind()));
		dataBean.setOrganCode(StrUtil.n2b(SomOrganHis.getOrganCode()));
		dataBean.setSorgCode(StrUtil.n2b(SomOrganHis.getSorgCode()));
		dataBean.setCnName(StrUtil.n2b(SomOrganHis.getCnName()));
		dataBean.setEnName(StrUtil.n2b(SomOrganHis.getEnName()));
		dataBean.setAbName(StrUtil.n2b(SomOrganHis.getAbName()));
		dataBean.setSorgPhone(StrUtil.n2b(SomOrganHis.getSorgPhone()));
		dataBean.setSorgFax(StrUtil.n2b(SomOrganHis.getSorgFax()));
		dataBean.setSorgPost(StrUtil.n2b(SomOrganHis.getSorgPost()));
		dataBean.setSorgAdds(StrUtil.n2b(SomOrganHis.getSorgAdds()));
		dataBean.setSorgWeb(StrUtil.n2b(SomOrganHis.getSorgWeb()));
		dataBean.setSorgEmail(StrUtil.n2b(SomOrganHis.getSorgEmail()));
		dataBean.setPurpose(StrUtil.n2b(SomOrganHis.getPurpose()));
		dataBean.setBusiness(StrUtil.n2b(SomOrganHis.getBusiness()));
		dataBean.setBusinessCode(StrUtil.n2b(SomOrganHis.getBusinessCode()));
		dataBean.setBusScope(StrUtil.n2b(SomOrganHis.getBusScope()));
		dataBean.setBorgName(StrUtil.n2b(SomOrganHis.getBorgName()));
		dataBean.setActArea(StrUtil.n2b(SomOrganHis.getActArea()));
		dataBean.setResideSource(StrUtil.n2b(SomOrganHis.getResideSource()));
		dataBean.setResidence(StrUtil.n2b(SomOrganHis.getResidence()));
		dataBean.setHousingOrgan(StrUtil.n2b(SomOrganHis.getHousingOrgan()));
		dataBean.setHousingArea(numFormat(SomOrganHis.getHousingArea()));
		dataBean.setLeasePeriod(StrUtil.n2b(SomOrganHis.getLeasePeriod()));
		dataBean.setFundingPeople(StrUtil.n2b(SomOrganHis.getFundingPeople()));
		dataBean.setRegMon(StrUtil.n2b(SomOrganHis.getRegMon()));
		dataBean.setCurrency(StrUtil.n2b(SomOrganHis.getCurrency()));
		dataBean.setCheckCapitalOrgan(StrUtil.n2b(SomOrganHis.getCheckCapitalOrgan()));
		dataBean.setMoneySource(StrUtil.n2b(SomOrganHis.getMoneySource()));
		dataBean.setBuildStatus(StrUtil.n2b(SomOrganHis.getBuildStatus()));
		dataBean.setAbsorpMember(StrUtil.n2b(SomOrganHis.getAbsorpMember()));
		dataBean.setFacilities(StrUtil.n2b(SomOrganHis.getFacilities()));
		dataBean.setUnitsNum(numFormat(SomOrganHis.getUnitsNum()));
		dataBean.setPeopleNum(numFormat(SomOrganHis.getPeopleNum()));
		dataBean.setCouncilNum(numFormat(SomOrganHis.getCouncilNum()));
		dataBean.setStandCouncilNum(numFormat(SomOrganHis.getStandCouncilNum()));
		dataBean.setMemberNum(numFormat(SomOrganHis.getMemberNum()));
		dataBean.setEngagedNum(numFormat(SomOrganHis.getEngagedNum()));
		dataBean.setPracticeNum(numFormat(SomOrganHis.getPracticeNum()));
		dataBean.setCheckYear(StrUtil.n2b(SomOrganHis.getCheckYear()));
		dataBean.setBuildDate(StrUtil.n2b(SomOrganHis.getBuildDate()));
		dataBean.setRegDate(StrUtil.n2b(SomOrganHis.getRegDate()));
		dataBean.setCancelReasonDesc(StrUtil.n2b(SomOrganHis.getCancelReasonDesc()));
		dataBean.setCancelReason(StrUtil.n2b(SomOrganHis.getCancelReason()));
		dataBean.setCancelDate(StrUtil.n2b(SomOrganHis.getCancelDate()));
		dataBean.setLiqResult(StrUtil.n2b(SomOrganHis.getLiqResult()));
		dataBean.setCredit(StrUtil.n2b(SomOrganHis.getCredit()));
		dataBean.setMorgName(StrUtil.n2b(SomOrganHis.getMorgName()));
		dataBean.setMorgArea(StrUtil.n2b(SomOrganHis.getMorgArea()));
		dataBean.setLegalPeople(StrUtil.n2b(SomOrganHis.getLegalPeople()));
		dataBean.setMainSorgName(StrUtil.n2b(SomOrganHis.getMainSorgName()));
		dataBean.setBranchCharger(StrUtil.n2b(SomOrganHis.getBranchCharger()));
		dataBean.setBorgPhone(StrUtil.n2b(SomOrganHis.getBorgPhone()));
		dataBean.setBorgPeople(StrUtil.n2b(SomOrganHis.getBorgPeople()));
		dataBean.setAppReason(StrUtil.n2b(SomOrganHis.getAppReason()));
		dataBean.setBusinessForPrint(StrUtil.n2b(SomOrganHis.getBusinessForPrint()));
		return dataBean;
	}
	
	/**
	 * NULL转空
	 * @param str
	 * @return
	 */
	public static BigDecimal numFormat(BigDecimal num) {
		if(num == null){
			BigDecimal bigDecimal = new BigDecimal("0");
			return bigDecimal;
		}else{
			return num;
		}
	}
	
	/**
	 * 根据taskCode查询社团历史信息
	 * @param pset
	 * @return
	 */
	public DataSet queryHis(ParameterSet pset) {
		DataSet ds = somOrganHisDao.query(pset);
		DataSet somOrganDs = new DataSet();
		if(ds.getCount()==1){
			SomOrganHis somOrganHis = (SomOrganHis)ds.getRecord(0).toBean(SomOrganHis.class);
			SomOrgan dataBean = new SomOrgan();
			dataBean  = getOrganFromHis(dataBean,somOrganHis);
			somOrganDs.addRecord(dataBean);
		}
		if(ds.getCount()==0){
			//需要将taskCode的查询条件清除
			pset.remove("TASK_CODE@=");
			pset.remove("TASK_CODE");
			return dao.query(pset);
		}
		return ds;
	}
	
	/**
	 * 取消社会组织限期停止活动状态
	 * 更新状态为已登记状态
	 */
	public void cancelLimitPeriod(ParameterSet pset){
		DataSet ds = this.query(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			Record record = ds.getRecord(i);
			SomOrgan somOrgan = (SomOrgan)record.toBean(SomOrgan.class);
			somOrgan.setSorgStatus("22");//已登记状态
			dao.update(somOrgan);
		}
	}
	/**
	 * 名称核准作废，更新sorg_status为7
	 */
	public void updateSorgStatus(ParameterSet pset){
		DataSet ds = this.query(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			Record record = ds.getRecord(i);
			SomOrgan somOrgan = (SomOrgan)record.toBean(SomOrgan.class);
			somOrgan.setSorgStatus("7");//已登记状态
			dao.update(somOrgan);
		}
	}
}
