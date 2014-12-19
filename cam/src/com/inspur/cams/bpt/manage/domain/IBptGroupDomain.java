package com.inspur.cams.bpt.manage.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

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
import com.inspur.cams.bpt.capital.data.BptCapitalDetail;
import com.inspur.cams.bpt.capital.data.BptCapitalSummary;
import com.inspur.cams.bpt.capital.data.BptCapitalsta;
import com.inspur.cams.bpt.capital.data.BptCompulsorySummary;
import com.inspur.cams.comm.baseinfo.data.BaseinfoFamily;
import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;

public interface IBptGroupDomain {

	
	
	/**
	 * 添加家庭信息和人员信息
	 * @param baseinfopeople 人员bean
	 * @param baseinfofamily 家庭bean
	 */
	public void insertBaseinfo(BaseinfoPeople baseinfopeople,BaseinfoFamily baseinfofamily);
	public void updateBaseinfo(BaseinfoPeople baseinfopeople,BaseinfoFamily baseinfofamily);
	/**
	 * 添加优抚人员信息
	 * @return
	 */
	public void insertBptPeople(BptPeople bptPeople);
	
	/**
	 * 查询优抚人员信息
	 */
	public DataSet queryBptPeople(ParameterSet pset);
	
	/**
	 * 查询家庭信息
	 * @param pset
	 * @return
	 */
	public DataSet queryFamilyInfo(ParameterSet pset);
	
	/**
	 * 更新人员信息
	 */
	public void updateBaseinfoPeople(BaseinfoPeople baseinfopeople);
	
	/**
	 * 添加人员伤残信息
	 * @param bptpeopledisability
	 */
	public void insertDisabilityInfo(BptPeopleDisability bptpeopledisability);
	/**
	 * 插入人员伤残信息
	 */
	
	public void insertBptPeopleDisability(BptPeopleDisability bptpeopledisability);
	/**
	 * 更新人员伤残信息
	 */
	public void updatePeopleDisability(BptPeopleDisability bptpeopledisability);
	
	/**
	 * 查询人员伤残信息
	 */
	public DataSet queryDisabilityInfo(ParameterSet pset);
	
	/**
	 * 查询在乡复员信息
	 */
	public DataSet queryDemobilizedInfo(ParameterSet pset);
	/**
	 * 添加残疾情况医学鉴定介绍信
	 * @param bptpeopledisability
	 */
	public void insertDisabilityIdentification(DisabilityIdentification disabilityIdentification);
	
	/**
	 * 添加伤残受理通知书
	 * @param bptApplyDisabilityNotice
	 */
	public void insertDisabilityNotice(BptApplyDisabilityNotice bptApplyDisabilityNotice);
	
	/**
	 * 添加遗属
	 */
	public void insertPeopleDependant(BptPeopleDependant bptPeopleDependant);
	
	/**
	 * 查询遗属信息
	 */
	public DataSet queryDependantInfo(ParameterSet pset);
	
	/**
	 * 添加在乡复员军人
	 * @param bptPeopleDemobilized
	 */
	public void insertPeopleDemobilized(BptPeopleDemobilized bptPeopleDemobilized);
	
	/**
	 * 添加带病回乡退伍军人
	 */
	public void insertPeopleDemobilizedIllness(BptPeopleDemobilizedIllness bptPeopleDemobilizedIllness);
	/**
	 * 更新在乡人员信息和相关优抚信息
	 */
	public void updateBptPeopleDemobilized(BptPeopleDemobilized bptPeopleDemobilized);
	/**
	 * 更新带病回乡人员信息和相关优抚信息
	 */
	public void updateBptPeopleDemobilizedIllness(BptPeopleDemobilizedIllness  bptPeopleDemobilizedIllness);
	/**
	 * 更新优抚人员信息
	 * @param bptPeople
	 */
	public void update(BptPeople bptPeople);
	/**********************************************LI START****************************************************/
	public DataSet queryWar(ParameterSet pset);
	/**
	 * author:liyanbing
	 * @param war 保存参战
	 * @return void
	 */
	public void insert(BptPeopleWar war);
	
	/**
	 * author:liyanbing
	 * @param war 保存参试
	 * @return void
	 */
	public void insertTested(BptPeopleTested peopleTested);
	
	public DataSet queryPeople(ParameterSet pset);
	public DataSet queryTested(ParameterSet pset);
	public DataSet queryTongJiTested(ParameterSet pset);
    public DataSet queryDataSet(ParameterSet pset);
	
	public void deleteBatch(ParameterSet pset);
	
	public void insert(BptCapitalsta bptCapitalsta);
	
	public void update(BptCapitalsta bptCapitalsta);
	
	public void batchInsert(List list);
	
	public void save(List list);
	
	public DataSet queryDataSetSummary(ParameterSet pset);
	
	public DataSet queryTemporary(ParameterSet params);
	
	public void saveBptCapialDetail(List<BptCapitalDetail> list);
	public void batchBptCapialDetail(List<BptCapitalDetail> list);
	public void batchInsertTemporaryHelp(List list);
	public DataSet queryDisabilityDataSet(ParameterSet pset);
	public void updateData(ParameterSet pset);
	public void deleteData(String[] delIds);
	public void insert(BptCapitalSummary bean);
	
	public DataSet queryCompulsorySummary(ParameterSet pset);
    
	public void insertCompulsorySummary(BptCompulsorySummary bptCompulsorySummary);
	public void deleteCapitalSummary(String[] delIds);
	public void deleteCompulsorySummary(String[] delIds);
	public void deleteRegisterId(ParameterSet param);
	public DataSet queryCatalogueArchives(ParameterSet pset);
	public DataSet queryTemporaryHelp(ParameterSet params);
	public void saveCatalogueArchives(List list);
	public void deleteCatalogueArchives(String delId);
	public DataSet queryUpdateTemporaryHelp(ParameterSet params);
	public void updateTemporaryHelp(BptTemporaryHelp bean);
	public void deleteTemporaryHelp(String[] delIds);
	/**********************************************LI END****************************************************/
	public DataSet queryDemobilizedFlowHeader(String peopleId);
}
