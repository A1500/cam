package com.inspur.cams.bpt.manage.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;
import com.inspur.cams.bpt.base.data.BptPeople;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilized;
import com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness;
import com.inspur.cams.bpt.base.data.BptPeopleDependant;
import com.inspur.cams.bpt.base.data.BptPeopleDisability;
import com.inspur.cams.bpt.base.data.BptPeopleTested;
import com.inspur.cams.bpt.base.data.BptPeopleWar;
import com.inspur.cams.bpt.base.data.BptTemporaryHelp;
import com.inspur.cams.bpt.base.data.DisabilityIdentification;
import com.inspur.cams.bpt.base.domain.IBptBaseinfoPeopleDomain;
import com.inspur.cams.bpt.edoc.domain.IBptCatalogueArchivesDomain;
import com.inspur.cams.bpt.edoc.domain.IBptCatalogueArchivesSaveDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDemobilizedIllnessDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDependantDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDisabilityDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleDomain;
import com.inspur.cams.bpt.base.domain.IBptPeopleTestedDomain;
import com.inspur.cams.bpt.base.domain.IBptTemporaryHelpDomain;
import com.inspur.cams.bpt.base.domain.IDisabilityIdentificationDomain;
import com.inspur.cams.bpt.base.domain.IDisabilityNoticeDomain;
import com.inspur.cams.bpt.base.domain.IWarDomain;
import com.inspur.cams.bpt.capital.data.BptCapitalDetail;
import com.inspur.cams.bpt.capital.data.BptCapitalSummary;
import com.inspur.cams.bpt.capital.data.BptCapitalsta;
import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;
import com.inspur.cams.bpt.capital.domain.IBptCapialDetailDomain;
import com.inspur.cams.bpt.capital.domain.IBptCapitalSummaryDomain;
import com.inspur.cams.bpt.capital.domain.IBptCapitalstaDomain;
import com.inspur.cams.bpt.capital.domain.IBptCompulsoryDetailsDomain;
import com.inspur.cams.bpt.capital.domain.IBptCompulsorySummaryDomain;
import com.inspur.cams.bpt.manage.domain.IBptGroupDomain;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

public class BptGroupDomain implements IBptGroupDomain {
	@Reference
	private IWarDomain bptWarDomain;

	@Reference
	private IBptPeopleTestedDomain bptPeopleTestedDomain;
	
	@Reference
	private IBptCapitalstaDomain bptCapitalstaDomain;
	
	@Reference
	private IBptTemporaryHelpDomain bptTemporaryHelpDomain;
	
	@Reference
	private IBptCapitalSummaryDomain bptCapitalSummaryDomain;
	
	@Reference
	private IBptCapialDetailDomain bptCapialDetailDomain;
	
    @Reference
    private IBptCompulsorySummaryDomain  bptCompulsorySummaryDomain;
    
    @Reference
    private IBptCompulsoryDetailsDomain bptCompulsoryDetailsDomain;
    
    @Reference
    private IBptCatalogueArchivesDomain bptCatalogueArchivesDomain;
    
    @Reference
    private IBptCatalogueArchivesSaveDomain bptCatalogueArchivesSaveDomain;
	
	
	/**
	 * 定义基本信息（家庭和人员）Domain
	 */
	@Reference
	private IBptBaseinfoPeopleDomain bptBaseinfoPeopleDomain;
	
	/**
	 * 定义优抚人员Domain
	 */
	@Reference
	private IBptPeopleDomain  bptPeopleDomain;
	
	/**
	 * 定义伤残人员Domain
	 */
	@Reference
	private IBptPeopleDisabilityDomain bptPeopleDisabilityDomain;

	/**
	 * 定义残疾鉴定介绍信Domain
	 */
	@Reference
	private IDisabilityIdentificationDomain disabilityIdentificationDomain;
	
	/**
	 * 定义伤残受理通知书Domain
	 */
	@Reference
	private IDisabilityNoticeDomain disabilityNoticeDomain;
	
	/**
	 * 定义遗属Domain
	 */
	@Reference
	private IBptPeopleDependantDomain bptPeopleDependantDomain;
	
	/**
	 * 定义在乡复员军人Domain
	 */
	@Reference
	private IBptPeopleDemobilizedDomain bptPeopleDemobilizedDomain;
	
	/**
	 * 定义带病回乡退伍军人Domain
	 */
	@Reference
	private IBptPeopleDemobilizedIllnessDomain demobilizedIllnessDomain;
	
	
	public void updateBptPeopleDemobilized(BptPeopleDemobilized bptPeopleDemobilized){
		bptPeopleDemobilizedDomain.updateBptPeopleDemobilized(bptPeopleDemobilized);
	}
	public void updateBptPeopleDemobilizedIllness(BptPeopleDemobilizedIllness  bptPeopleDemobilizedIllness){
		demobilizedIllnessDomain.updateBptPeopleDemobilizedIllness(bptPeopleDemobilizedIllness);
	}
	/**
	 * 更新优抚人员信息
	 * @param bptPeople
	 */
	public void update(BptPeople bptPeople) {
		// TODO Auto-generated method stub
		bptPeopleDomain.update(bptPeople);
	}
	/*************************************li START*****************************************************/
	public DataSet queryWar(ParameterSet pset) {
		return bptWarDomain.queryWar(pset);
	}

	/**
	 * author:liyanbing
	 * 
	 * @param war
	 *            保存参战
	 * @return void
	 */
	public void insert(BptPeopleWar war) {
		bptWarDomain.insert(war);

	}

	public DataSet queryTested(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptPeopleTestedDomain.queryTested(pset);
	}

	public DataSet queryTongJiTested(ParameterSet pset){
		return bptPeopleTestedDomain.queryTongJiTested(pset);
	}
	/**
	 * author:liyanbing
	 * 
	 * @param war
	 *            保存参试
	 * @return void
	 */
	public void insertTested(BptPeopleTested peopleTested) {
		bptPeopleTestedDomain.insertTested(peopleTested);
	}

	public DataSet queryDataSet(ParameterSet pset) {
		return bptCapitalstaDomain.queryDataSet(pset);
	}

	public void deleteBatch(ParameterSet pset) {
		// TODO Auto-generated method stub
		bptCapitalstaDomain.deleteBatch(pset);
	}

	public void insert(BptCapitalsta bptCapitalsta) {
		// TODO Auto-generated method stub
		bptCapitalstaDomain.insert(bptCapitalsta);
	}

	public void update(BptCapitalsta bptCapitalsta) {
		// TODO Auto-generated method stub
		bptCapitalstaDomain.update(bptCapitalsta);
	}

	public void batchInsert(List list) {
		// TODO Auto-generated method stub
		bptCapitalstaDomain.batchInsert(list);
	}

	public void save(List list) {
		// TODO Auto-generated method stub
		bptCapitalstaDomain.save(list);
	}
    
	public void batchInsertTemporaryHelp(List list){
		bptTemporaryHelpDomain.batchInsertTemporaryHelp(list);
	}
	
	public DataSet queryTemporary(ParameterSet params) {
		return bptTemporaryHelpDomain.queryTemporary(params);
	}

	public DataSet queryDataSetSummary(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptCapitalSummaryDomain.queryDataSetSummary(pset);
	}

	public void insert(BptCapitalSummary bean) {
		bptCapitalSummaryDomain.insert(bean);

	}

	public DataSet queryDisabilityDataSet(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptCapialDetailDomain.queryDisabilityDataSet(pset);
	}

	public void updateData(ParameterSet pset) {
		// TODO Auto-generated method stub
		bptCapialDetailDomain.updateData(pset);
	}

	public void deleteData(String[] delIds) {
		// TODO Auto-generated method stub
		bptCapialDetailDomain.deleteData(delIds);
	}

	public void saveBptCapialDetail(List<BptCapitalDetail> list) {
		// TODO Auto-generated method stub
		bptCapialDetailDomain.saveBptCapialDetail(list);
	}

	public DataSet queryCompulsorySummary(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptCompulsorySummaryDomain.queryCompulsorySummary(pset);
	}

	public void insertCompulsorySummary(
			BptCompulsorySummary bptCompulsorySummary) {
		bptCompulsorySummaryDomain
				.insertCompulsorySummary(bptCompulsorySummary);
	}

	public void batchBptCapialDetail(List<BptCapitalDetail> list) {
		bptCapialDetailDomain.batchBptCapialDetail(list);
		
	}
	
	public void deleteCapitalSummary(String[] delIds) {
		// TODO Auto-generated method stub
		bptCapitalSummaryDomain.deleteCapitalSummary(delIds);
	}
    
	public void deleteCompulsorySummary(String[] delIds){
		bptCompulsorySummaryDomain.deleteCompulsorySummary(delIds);
	}
	
	public void deleteRegisterId(ParameterSet param){
		bptCompulsorySummaryDomain.deleteRegisterId(param);
	}
	
	public DataSet queryCatalogueArchives(ParameterSet pset) {
		// TODO Auto-generated method stub
		return bptCatalogueArchivesDomain.queryCatalogueArchives(pset);
		
	}
	
	public DataSet queryTemporaryHelp(ParameterSet params) {
		// TODO Auto-generated method stub
		return bptTemporaryHelpDomain.queryTemporaryHelp(params);
	}
	
	public void saveCatalogueArchives(List list){
		bptCatalogueArchivesSaveDomain.saveCatalogueArchives(list);
	}
	
	public void deleteCatalogueArchives(String delId){
		bptCatalogueArchivesSaveDomain.deleteCatalogueArchives(delId);
	}
	
	public DataSet queryUpdateTemporaryHelp(ParameterSet params){
		return bptTemporaryHelpDomain.queryUpdateTemporaryHelp(params);
	}
	
	public void updateTemporaryHelp(BptTemporaryHelp bean){
		bptTemporaryHelpDomain.updateTemporaryHelp(bean);
	}
	
	public void deleteTemporaryHelp(String[] delIds){
		bptTemporaryHelpDomain.deleteTemporaryHelp(delIds);
	}
	/**************************************li END*****************************************************/
	
	/**
	 * 添加家庭信息和人员信息
	 */
	public void insertBaseinfo(BaseinfoPeople baseinfopeople,BaseinfoFamily baseinfofamily){
		bptBaseinfoPeopleDomain.saveList(baseinfopeople, baseinfofamily);
	}
	/**
	 * 
	 * 更新家庭信息和人员信息
	 */
	public void updateBaseinfo(BaseinfoPeople baseinfopeople,BaseinfoFamily baseinfofamily){
		bptBaseinfoPeopleDomain.updateList(baseinfopeople, baseinfofamily);
	}
	/**
	 * 添加优抚人员信息
	 */
	public void insertBptPeople(BptPeople bptPeople){
		bptPeopleDomain.insert(bptPeople);
	}
	
	/**
	 * 查询优抚人员信息
	 */
	public DataSet queryBptPeople(ParameterSet pset){
		return bptPeopleDomain.query(pset);
	}
	
	/**
	 * 查询家庭信息
	 * @param pset
	 * @return
	 */
	public DataSet queryFamilyInfo(ParameterSet pset){
		return bptBaseinfoPeopleDomain.queryBaseinfoFamily(pset);
	}
	
	/**
	 * 更新人员信息
	 */
	public void updateBaseinfoPeople(BaseinfoPeople baseinfopeople){
		bptBaseinfoPeopleDomain.updateBaseinfoPeople(baseinfopeople);
	}
	
	/**
	 * 添加人员伤残信息
	 */
	public void insertDisabilityInfo(BptPeopleDisability bptpeopledisability){
		bptPeopleDisabilityDomain.saveBptPeopleDisabilityList(bptpeopledisability);
	}
	/**
	 * 插入人员伤残信息
	 */
	
	public void insertBptPeopleDisability(BptPeopleDisability bptpeopledisability) {
		this.bptPeopleDisabilityDomain.insertBptPeopleDisability(bptpeopledisability);
	}
	/**
	 * 更新人员伤残信息
	 */
	public void updatePeopleDisability(BptPeopleDisability bptpeopledisability){
		System.out.println("0");
		bptPeopleDisabilityDomain.updatePeopleDisability(bptpeopledisability);
	}
	
	/**
	 * 查询人员伤残信息
	 */
	public DataSet queryDisabilityInfo(ParameterSet pset){
		 return bptPeopleDisabilityDomain.queryBptPeopleDisability(pset);
	}

	/**
	 * 添加残疾情况医学鉴定介绍信
	 * @param bptpeopledisability
	 */
	public void insertDisabilityIdentification(DisabilityIdentification disabilityIdentification){
		disabilityIdentificationDomain.insert(disabilityIdentification);
	}
	
	/**
	 * 添加伤残受理通知书
	 * @param bptApplyDisabilityNotice
	 */
	public void insertDisabilityNotice(BptApplyDisabilityNotice bptApplyDisabilityNotice){
		disabilityNoticeDomain.insert(bptApplyDisabilityNotice);
	}

	public DataSet queryPeople(ParameterSet pset) {
		return bptBaseinfoPeopleDomain.queryBaseinfoPeople(pset);
	}
	
	/**
	 * 通过调用遗属Domain添加遗属信息
	 */
	public void insertPeopleDependant(BptPeopleDependant bptPeopleDependant){
		bptPeopleDependantDomain.insert(bptPeopleDependant);
	}
	
	/**
	 * 查询遗属信息
	 */
	public DataSet queryDependantInfo(ParameterSet pset){
		return bptPeopleDependantDomain.query(pset);
	}
	
	/**
	 * 添加在乡复员军人
	 * @param bptPeopleDemobilized
	 */
	public void insertPeopleDemobilized(BptPeopleDemobilized bptPeopleDemobilized){
		bptPeopleDemobilizedDomain.insert(bptPeopleDemobilized);
	}
	
	/**
	 * 添加带病回乡退伍军人
	 */
	public void insertPeopleDemobilizedIllness(BptPeopleDemobilizedIllness bptPeopleDemobilizedIllness){
		demobilizedIllnessDomain.insert(bptPeopleDemobilizedIllness);
	}

	/**
	 * 在乡复员
	 */
	public DataSet queryDemobilizedFlowHeader(String peopleId) {
		// TODO Auto-generated method stub
		return bptBaseinfoPeopleDomain.queryDemobilizedFlowHeader(peopleId);
	}
	public DataSet queryDemobilizedInfo(ParameterSet pset) {
		return bptPeopleDemobilizedDomain.query(pset);
	}
}